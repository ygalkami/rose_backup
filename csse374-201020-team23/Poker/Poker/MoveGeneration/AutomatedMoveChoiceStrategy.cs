using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	class AutomatedMoveChoiceStrategy : IMoveChoiceStrategy
	{

		public Move getMove(DealState currentDealState, List<Move> legalMoves, Card[] cards)
		{
            Playout p = new Playout();
            int score = 0;

            if (currentDealState.dealersHand == null)
            {
                score = p.playout(cards[0].getRawData(), cards[1].getRawData());
            }
            else if (currentDealState.dealersHand.Count == 3)
            {
                score = p.playout(cards[0].getRawData(), cards[1].getRawData(),
                    currentDealState.dealersHand[0].getRawData(),
                    currentDealState.dealersHand[1].getRawData(),
                    currentDealState.dealersHand[2].getRawData());
            }
            else if (currentDealState.dealersHand.Count == 4)
            {
                score = p.playout(cards[0].getRawData(), cards[1].getRawData(),
                    currentDealState.dealersHand[0].getRawData(),
                    currentDealState.dealersHand[1].getRawData(),
                    currentDealState.dealersHand[2].getRawData(),
                    currentDealState.dealersHand[3].getRawData());
            }
            else
            {
                score = p.score(cards[0].getRawData(), cards[1].getRawData(),
					currentDealState.dealersHand[0].getRawData(),
					currentDealState.dealersHand[1].getRawData(),
					currentDealState.dealersHand[2].getRawData(),
					currentDealState.dealersHand[3].getRawData(),
					currentDealState.dealersHand[4].getRawData()
					);
            }

           // int division_size = (1169 - 500) / legalMoves.Count;
            int count = 0;
            double x = (Math.Log(score, legalMoves.Count));
            double max = (Math.Log(1169, legalMoves.Count));
            double min = (Math.Log(370, legalMoves.Count));
            double division_size = (max-min) / legalMoves.Count;
            for (double base_pos = min; base_pos <= max; base_pos += division_size)
            {
                if (x <= base_pos)
                {
                    return legalMoves[count-1];
                }
                count++;
            }
            return legalMoves[0];
		}
	}
}
