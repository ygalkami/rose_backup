using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	class FlopState : DealState
	{
		public FlopState(List<Player> players, int pot, GameController game)
		{
			this.game = game;
			this.activePlayers = players;
			this.dealersHand = new List<Card>(0);
			this.potValue = pot;
			this.currentBet = 0;
		}

		public override void dealCards()
		{
			for (int i = 0; i < 3; i++)
			{
				this.dealersHand.Add(game.deck.Pop());
				this.game.cardDealt(PlayerPosition.Top, this.dealersHand[i]);
			}

		}

		public override DealState getNextState()
		{
			this.game.dealStateEnded(this);
			return new TurnState(this.activePlayers, this.dealersHand, this.potValue, this.game);
		}


	}
}
