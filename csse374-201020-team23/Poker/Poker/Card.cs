using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Controls;
using System.Windows.Media.Imaging;

namespace Poker
{
	public class Card
	{
		private int cardIndex;
		private int value;
		private string suit;
        private string imageSource;

		//constructor
		public Card(int index)
		{
			this.cardIndex = index;
			this.value = determineValue(index);
			this.suit = determineSuit(index);
            this.imageSource = String.Concat("/Images/cards/", index.ToString(), ".png");

		}

		private string determineSuit(int index){
			if (index < 14)
				return "club";
			else if (index >= 14 && index < 27)
				return "diamond";
			else if (index >=27 && index < 40)
				return "heart";
			else
				return "spade";
		}
		private int determineValue(int index) {
			return index % 13 + 1; 
		}
        public int getRawData()
        {
            return cardIndex;
        }
        public string getImageSource()
        {
            return this.imageSource;
        }
        public int getValue()
        {
            return this.value;
        }
	}

}
