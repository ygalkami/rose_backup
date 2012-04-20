using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	class ShowdownState : DealState
	{
		public ShowdownState(List<Player> players, List<Card> dealersCards, int pot, GameController game)
		{
			this.game = game;
			this.activePlayers = players;
            this.dealersHand = dealersCards;
			this.potValue = pot;
			this.currentBet = 0;
		}

		public override void dealCards()
		{ 
			//no cards are dealt in the showdown
		}
		public override void handleBettingSession()
		{ 
			//no bets are made in the showdown
		}
		public override bool gameIsDone()
		{
			this.game.dealStateEnded(this);
			return true;
		}
		public override DealState getNextState()
		{
			throw new Exception("The game should never get here. gameIsDone should have flagged true, that the game is over.");
		}

	}
}
