using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	class Check : Move
	{
		public Check()
		{
			this.setName("Check");
			this.amountPotRaised = 0;
			this.currentBetRaised = 0;
		}
		public override bool amountIsNeeded()
		{
			return false;
		}
	}
}
