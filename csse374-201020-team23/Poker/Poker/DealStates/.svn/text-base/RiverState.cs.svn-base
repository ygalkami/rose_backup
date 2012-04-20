using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	class RiverState : DealState
	{

		public RiverState(List<Player> players, List<Card> dealersCards, int pot, GameController game)
		{
			this.game = game;
			this.activePlayers = players;
			this.dealersHand = dealersCards;
			this.potValue = pot;
			this.currentBet = 0;
		}

		public override void dealCards()
		{
			this.dealersHand.Add(game.deck.Pop());
			this.game.cardDealt(PlayerPosition.Top, this.dealersHand[4]);
		}

		public override DealState getNextState()
		{
			this.game.dealStateEnded(this);
			return new ShowdownState(this.activePlayers, this.dealersHand, this.potValue, this.game);
		}
	}
}
