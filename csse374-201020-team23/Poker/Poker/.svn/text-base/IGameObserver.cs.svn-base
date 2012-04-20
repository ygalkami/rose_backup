using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	public interface IGameObserver
	{
		void cardDealt(PlayerPosition position, Card card);
		void stackUpdated(PlayerPosition position, int stackValue);
		void potUpdated(int potValue);
		void playerRaised(PlayerPosition position, int potValue, int stackValue, int raiseAmount);
		void playerCalled(PlayerPosition position, int potValue, int stackValue);
		void playerChecked(PlayerPosition position);
		void playerFolded(PlayerPosition position);
		void dealStateEnded(DealState state);
        void playerWon(PlayerPosition position, int amount);
		void gameEnded();
        void gameReset();
        void playersOutOfMoney();
	}
}
