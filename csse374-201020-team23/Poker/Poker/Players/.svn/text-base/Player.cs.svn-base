using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	public class Player
	{
		public PlayerPosition position;
		public Card[] cards;
        private IMoveChoiceStrategy moveChooser;
        public int startingStack;
		public int currentStack;
		public int betInRound;
		public bool folded;

		public Player(IMoveChoiceStrategy moveChooser, PlayerPosition pos, int stack)
		{
			this.moveChooser = moveChooser;
			this.position = pos;
			this.startingStack = stack;
			this.currentStack = stack;
			this.betInRound = 0;
			this.folded = false;
			this.cards = new Card[2];
		}

		public Move makeMove(DealState currentDealState) //this method needs to be abstract, but is temporarily working for all players
		{
			Move myMove = this.moveChooser.getMove(currentDealState, currentDealState.game.legalMoveGenerator.generateLegalMoves(currentDealState, this), this.cards);
			this.currentStack = this.currentStack - myMove.amountPotRaised;
			this.betInRound = this.betInRound + myMove.currentBetRaised;
			return myMove;

		}
		
		public void receiveCard(Card card)
		{
			if (cards[0] == null)
				cards[0] = card;
			else
				cards[1] = card;
		}
		public void reset()
		{
			this.startingStack = this.currentStack;
			this.betInRound = 0;
			this.folded = false;
			this.cards[0] = null;
			this.cards[1] = null;
		}
		
	}
}
