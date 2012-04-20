using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	public abstract class DealState
	{
		public GameController game;
		public List<Player> activePlayers;
		public List<Card> dealersHand;
		public int potValue;
		public int currentBet;

		public abstract void dealCards();
		public virtual void handleBettingSession()
		{
			resetBetInRounds();
			PlayerQueue playersInSession = initializePlayerQueue();
			Player firstPlayerWithNoChoice = null;
			bool isFirstPlayersTurn = true;
			bool isSessionOver = false;

			while (!isSessionOver && (playersInSession.getCount() > 1))
			{
				Player currentActor = playersInSession.getCurrentPlayer();
				if (currentActor == firstPlayerWithNoChoice)
				{
					isSessionOver = true;
					break;
				}
				Move moveChoice = currentActor.makeMove(this);
				updateGame(moveChoice, currentActor);
				if (moveChoice is Fold)
				{
					playersInSession.removeCurrentPlayer();
				}
				else if (moveChoice is Check)
				{
					playersInSession.advanceToNextPlayer();
				}
				else if (moveChoice is Call)
				{
					if (currentActor.currentStack != 0)
					{
						playersInSession.advanceToNextPlayer();
					}
					else
					{
						playersInSession.removeCurrentPlayer();
					}
				}
				else if (moveChoice is Raise)
				{
					firstPlayerWithNoChoice = currentActor;
					playersInSession.advanceToNextPlayer();
				}

				if (isFirstPlayersTurn)
				{
					firstPlayerWithNoChoice = currentActor;
					isFirstPlayersTurn = false;
				}

			}

		}

		public virtual bool gameIsDone()
		{
			//if there is still more than one player in the game, continue
			int playersInGame = 0;
			foreach (Player p in this.game.players)
			{
				if (p.folded == false)
				{
					playersInGame++;
				}
			}
			return (playersInGame < 2);
		}

		public abstract DealState getNextState();

		public void resetBetInRounds()
		{
			foreach (Player p in activePlayers)
			{
				p.betInRound = 0;
			}

		}
		
		private PlayerQueue initializePlayerQueue()
		{
			PlayerQueue playersInSession = new PlayerQueue();
			foreach (Player p in activePlayers)
			{
				playersInSession.addPlayer(p);
			}
			return playersInSession;
		}
		
		public void updateGame(Move moveChoice, Player currentActor)
		{
			if (moveChoice is Fold)
			{
				currentActor.folded = true;
				activePlayers.Remove(currentActor);
				this.game.playerFolded(currentActor.position);
			}
			else if (moveChoice is Check)
			{
				this.game.playerChecked(currentActor.position);
			}
			else if (moveChoice is Call)
			{
				this.potValue = this.potValue + moveChoice.amountPotRaised;
				this.game.playerCalled(currentActor.position, this.potValue, currentActor.currentStack);
				if (currentActor.currentStack == 0)
				{
					activePlayers.Remove(currentActor);
				}
			}
			else if (moveChoice is Raise)
			{
				this.potValue = this.potValue + moveChoice.amountPotRaised;
				this.currentBet = this.currentBet + moveChoice.currentBetRaised;
				this.game.playerRaised(currentActor.position, this.potValue, currentActor.currentStack, moveChoice.currentBetRaised);
			}
		}
		
	}
	
	
}
