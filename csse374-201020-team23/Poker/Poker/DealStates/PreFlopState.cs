using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	class PreFlopState : DealState
	{
		public PreFlopState(List<Player> players, GameController game)
		{
			this.game = game;
			this.activePlayers = players;
			this.potValue = 0;
			this.currentBet = 0;

			game.potUpdated(this.potValue);
			foreach (Player player in activePlayers)
			{
				game.stackUpdated(player.position, player.currentStack);
			}

		}

		public override void dealCards()
		{
			//deal player cards
			foreach (Player player in activePlayers)
			{
				player.receiveCard(game.deck.Pop());
				player.receiveCard(game.deck.Pop());

				this.game.cardDealt(player.position, player.cards[0]);
				this.game.cardDealt(player.position, player.cards[1]);

			}
			
		}

        public override void handleBettingSession()
        {
            resetBetInRounds();

            //do preflop bets
            activePlayers[0].currentStack = activePlayers[0].currentStack - 10;
            activePlayers[0].betInRound = 10;
            updateGame(new Raise(10, 10), activePlayers[0]);
            activePlayers[1].currentStack = activePlayers[1].currentStack - 20;
            activePlayers[1].betInRound = 20;
            updateGame(new Raise(20, 10), activePlayers[1]);


            //create player queue but put the first two players at the bottom because they did the blinds
            PlayerQueue playersInSession = new PlayerQueue();
            for (int i = 2; i < activePlayers.Count; i++)
            {
                playersInSession.addPlayer(activePlayers[i]);
            }
            playersInSession.addPlayer(activePlayers[0]);
            playersInSession.addPlayer(activePlayers[1]);

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

		public override DealState getNextState()
		{
			this.game.dealStateEnded(this);
			return new FlopState(this.activePlayers, this.potValue, this.game);
		}

	}
}
