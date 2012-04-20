using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	public class PlayerFactory
	{
		public Player createHumanPlayer(IMoveChoiceStrategy moveChooser, PlayerPosition position, int stack)
		{
			return this.createPlayer(moveChooser, position, stack);
		}
		public Player createAutoPlayer(PlayerPosition position, int stack)
		{
			return this.createPlayer(new AutomatedMoveChoiceStrategy(), position, stack);
		}
		private Player createPlayer(IMoveChoiceStrategy moveChooser, PlayerPosition position, int stack)
		{
			return new Player(moveChooser, position, stack);
		}
		
	}
}
