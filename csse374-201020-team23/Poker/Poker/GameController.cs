using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	public enum PlayerPosition { Right, Middle, Left, Top };

	public class GameController
	{
		private List<IGameObserver> observers = new List<IGameObserver>();
		public Player[] players;
		public GameState currentGameState;
		public Stack<Card> deck;
		public LegalMoveGenerator legalMoveGenerator;

		public int setRaiseAmount;
		private int startingStackValue;

		/*
		 * game constructor
		 */
		public GameController(int numberOfPlayers, IMoveChoiceStrategy humanMoveChooser)
		{
			this.setRaiseAmount = 20;
			this.startingStackValue = 500;

			PlayerFactory playerFactory = new PlayerFactory();
			this.players = new Player[numberOfPlayers];
			if (numberOfPlayers == 3)
			{
				this.players[0] = playerFactory.createAutoPlayer(PlayerPosition.Right, this.startingStackValue);
				this.players[1] = playerFactory.createHumanPlayer(humanMoveChooser, PlayerPosition.Middle, this.startingStackValue);
				this.players[2] = playerFactory.createAutoPlayer(PlayerPosition.Left, this.startingStackValue);
			}
			else 
			{
				this.players[0] = playerFactory.createAutoPlayer(PlayerPosition.Right, this.startingStackValue);
				this.players[1] = playerFactory.createAutoPlayer(PlayerPosition.Left, this.startingStackValue);
			}

			this.legalMoveGenerator = new LegalMoveGenerator();

			this.deck = new Stack<Card>();
			this.initializeDeck();
		}

		/*
		 * IGameObserver Methods
		 */
		public void addGameObserver(IGameObserver go)
		{
			this.observers.Add(go);
		}
		public void cardDealt(PlayerPosition position, Card card)
		{
			foreach (IGameObserver go in this.observers) 
			{
				go.cardDealt(position, card);
			}
		}
		public void stackUpdated(PlayerPosition position, int stackValue)
		{
			foreach (IGameObserver go in this.observers)
			{
				go.stackUpdated(position, stackValue);
			}
		}
		public void potUpdated(int potValue)
		{
			foreach (IGameObserver go in this.observers)
			{
				go.potUpdated(potValue);
			}
		}
		public void playerRaised(PlayerPosition position, int potValue, int stackValue, int raiseAmount)
		{
			foreach (IGameObserver go in this.observers)
			{
				go.playerRaised(position, potValue, stackValue, raiseAmount);
			}
		}
		public void playerCalled(PlayerPosition position, int potValue, int stackValue)
		{
			foreach (IGameObserver go in this.observers)
			{
				go.playerCalled(position, potValue, stackValue);
			}		
		}
		public void playerChecked(PlayerPosition position)
		{
			foreach (IGameObserver go in this.observers)
			{
				go.playerChecked(position);
			}
		}
		public void playerFolded(PlayerPosition position)
		{
			foreach (IGameObserver go in this.observers)
			{
				go.playerFolded(position);
			}
		}
		public void dealStateEnded(DealState state)
		{
			foreach (IGameObserver go in this.observers)
			{
				go.dealStateEnded(state);
			}
		}
        public void playerWon(PlayerPosition position, int amount)
        {
            foreach (IGameObserver go in this.observers)
            {
                go.playerWon(position, amount);
            }
        }
		public void gameEnded()
		{
			foreach (IGameObserver go in this.observers)
			{
				go.gameEnded();
			}
		}
        public void gameReset()
        {
            foreach (IGameObserver go in this.observers)
            {
                go.gameReset();
            }
        }
        public void playersOutOfMoney()
        {
            foreach (IGameObserver go in this.observers)
            {
                go.playersOutOfMoney();
            }
        }


		/*
		 * System Operations
		 */
		public void beginGame()
		{
			this.currentGameState = new GameState(players, this);
			this.currentGameState.playGame();

		}

		public void playAgain()
		{
            this.gameReset();
			this.initializeDeck();
            List<Player> newPlayers = this.reInitializePlayers();
            //if there aren't enough players with enough money to play, the game cannot continue
            if (newPlayers.Count < 2)
            {
                playersOutOfMoney();
            }
            else
            {
                this.currentGameState = new GameState(newPlayers.ToArray(), this);
                this.currentGameState.playGame();
            }
            
			
		}


		/*
		 * Private Helper Methods
		 */
		private void initializeDeck()
		{
			deck.Clear();
			for (int i = 1; i < 53; i++)
			{
				deck.Push(new Card(i));
			}

			shuffleDeck();
		
		}
        private List<Player> reInitializePlayers()
        {
            List<Player> playersInNextGame = new List<Player>();
            foreach (Player p in this.players)
            {
                if (p.currentStack >= this.setRaiseAmount)
                {
                    p.reset();
                    playersInNextGame.Add(p);
                }
            }
            return playersInNextGame;
        }
		private void shuffleDeck()
		{
			List<Card> deckList = new List<Card>();
			foreach (Card c in deck)
			{
				deckList.Add(c);
			}
			deck.Clear();
			Random r = new Random();
			for (int i = 0; i < 52; i++)
			{
				int c = r.Next(51);
				Card temp = deckList[c];
				deckList[c] = deckList[i];
				deckList[i] = temp;
			}
			foreach (Card c in deckList)
			{
				deck.Push(c);
			}
			
		}
	
	}

}
