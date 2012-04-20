using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	public class LegalMoveGenerator
	{

		public List<Move> generateLegalMoves(DealState currentDealState, Player player)
		{
			List<Move> legalMoves = new List<Move>();

			bool canRaise = (player.currentStack >= (currentDealState.currentBet - player.betInRound + currentDealState.game.setRaiseAmount));
			bool canCheck = (player.betInRound == currentDealState.currentBet);

            legalMoves.Add(new Fold());
			if (canCheck)
			{
				legalMoves.Add(new Check());
			}
			else
			{
				int callAmount = currentDealState.currentBet - player.betInRound;
			    if (callAmount > player.currentStack)
				{
					callAmount = player.currentStack;
				}
				legalMoves.Add(new Call(callAmount));
			}

			if (canRaise)
			{
				int increments = (player.currentStack - (currentDealState.currentBet - player.betInRound)) / currentDealState.game.setRaiseAmount;
				int raiseAmount = 0;
				int amountStackDeducted = 0;
				for (int i = 1; i < increments + 1; i++)
				{
					raiseAmount = i * currentDealState.game.setRaiseAmount;
					amountStackDeducted = currentDealState.currentBet - player.betInRound + raiseAmount;
					legalMoves.Add(new Raise(amountStackDeducted, raiseAmount));
				}
			}

			

			return legalMoves;
		}


	}
}
