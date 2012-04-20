using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	class PlayerQueue
	{
		private Queue<Player> players;

		public PlayerQueue()
		{
			this.players = new Queue<Player>();
		}

		public void addPlayer(Player p)
		{
			this.players.Enqueue(p);
		}

		public Player getCurrentPlayer()
		{
			return this.players.Peek();
		}

		public void advanceToNextPlayer()
		{
			this.players.Enqueue(this.players.Dequeue());
		}

		public void removeCurrentPlayer()
		{
			this.players.Dequeue();
		}
		
		public int getCount()
		{
			return this.players.Count;
		}
	}
}
