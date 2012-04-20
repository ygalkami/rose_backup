using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	class Raise : Move
	{
		public Raise(int totalAmt, int raiseAmt)
		{
			this.setName("Raise");
			this.amountPotRaised = totalAmt;
			this.currentBetRaised = raiseAmt;
		}

		public override bool amountIsNeeded()
		{
			return true;
		}

	}
}
