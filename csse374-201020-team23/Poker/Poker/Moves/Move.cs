using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	public abstract class Move
	{
		private string name;
		public int amountPotRaised;
		public int currentBetRaised;

		public abstract bool amountIsNeeded();

		public void setName(string name)
		{
			this.name = name;
		}
		public string getName()
		{
			return this.name;
		}

		public override string ToString()
		{
			if (this.amountIsNeeded())
			{
				return String.Concat(this.name, " by $", this.currentBetRaised.ToString());
			}
			else
			{
				return this.name;
			}
		}
	}
}
