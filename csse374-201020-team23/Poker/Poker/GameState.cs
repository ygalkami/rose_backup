using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	public class GameState
	{
		public DealState currentDealState; 	    //preflop (0 cards), flop (3 cards), turn (4 cards), river (5 cards), showdown (showing cards)

		public GameState(Player[] players, GameController game)
		{
			List<Player> activePlayers = new List<Player>();
			foreach (Player p in players)
			{
				activePlayers.Add(p);
			}
			this.currentDealState = new PreFlopState(activePlayers, game);
		}

		public void playGame()
		{
            //main game loop
			while (true)
			{
				this.currentDealState.dealCards();
				this.currentDealState.handleBettingSession();
				bool gameDone = this.currentDealState.gameIsDone();
				if (gameDone)
				{
					break;
				}
				else
				{
					this.currentDealState = this.currentDealState.getNextState();
				}
			}
			this.currentDealState.game.gameEnded();
			
            //Decide who won
            List<Player> winnerList = determineWinnerList();
            if (winnerList.Count == 1)                      //don't determine winner if the game ends in a fold
                distributePot(winnerList[0], winnerList);   //in the event of a fold, distribute all money to the remaining player
            else
            {
                chooseWinner(winnerList);             //determine who wins overall out of the list of potential winners
            }
		}

        private void chooseWinner(List<Player> playersToEvaluate) //given a list of players, find the winner and distribute money accordingly
        {
            HashSet<Player> scores = new HashSet<Player>();
            Player currentLeader = playersToEvaluate[0];
            foreach (Player p in playersToEvaluate)
            {
                if (evaluateHand(p) > evaluateHand(currentLeader))
                    currentLeader = p;
            }
            playersToEvaluate.Remove(currentLeader);
            distributePot(currentLeader, playersToEvaluate);
        }
        private int evaluateHand(Player player) //evaluates the hand of a player
        {
            Playout p = new Playout();
            return p.score(player.cards[0].getRawData(),
                                   player.cards[1].getRawData(),
                                   currentDealState.dealersHand[0].getRawData(),
                                   currentDealState.dealersHand[1].getRawData(),
                                   currentDealState.dealersHand[2].getRawData(),
                                   currentDealState.dealersHand[3].getRawData(),
                                   currentDealState.dealersHand[4].getRawData());
        }
        private List<Player> determineWinnerList()  //determines who can still possibly win the game
        {
            List<Player> winnerList = new List<Player>();
            foreach (Player p in this.currentDealState.game.players)
            {
                if (!p.folded)
                    winnerList.Add(p);
                //check if player has folded -> ignore in winner-list    
            }

            return winnerList;
                        
        }
        private void distributePot(Player p, List<Player> playersLeft)             //distribute pot
        {
            if (this.currentDealState.activePlayers.Contains(p))  //if the winner is still active, give him all the money
            {
                p.currentStack += this.currentDealState.potValue;
                this.currentDealState.game.stackUpdated(p.position, p.currentStack);
                this.currentDealState.game.playerWon(p.position, this.currentDealState.potValue);

                this.currentDealState.potValue = 0;
                this.currentDealState.game.potUpdated(this.currentDealState.potValue);
                
            }
            else                            //if the winner has run out of money, give him his alloted amount. then, distribute the rest accordingly
            {
                int winAmount = this.currentDealState.game.players.Length * p.betInRound;
                p.currentStack += winAmount;
                this.currentDealState.game.stackUpdated(p.position, p.currentStack);
                this.currentDealState.game.playerWon(p.position, winAmount);

                this.currentDealState.potValue -= winAmount;
                this.currentDealState.game.potUpdated(this.currentDealState.potValue);

                if (playersLeft.Count != 0)
                {
                    chooseWinner(playersLeft);
                }
            }
        }
	}
}
