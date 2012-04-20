using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	class Call : Move
	{

		public Call(int totalAmt)
		{
			this.setName("Check");
			this.amountPotRaised = totalAmt;
			this.currentBetRaised = 0;
		}

		public override bool amountIsNeeded()
		{
			return false;
		}
	}
}
