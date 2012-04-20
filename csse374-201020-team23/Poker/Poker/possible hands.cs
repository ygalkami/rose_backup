using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;

namespace Poker
{
    class hands
    {
        private const int QUAD_OFFSET = 168;
        private const int PAIR_OFFSET = 0;
        private const int TWO_PAIR_OFFSET = 13;
        private const int FULL_HOUSE_OFFSET = 101;
        private const int TRIPLE_OFFSET = 80;
        private const int STRAIGHT_OFFSET = 94;
        private const int STRAIGHT_FLUSH = 1169;

        int[][] HAND_TABLE = new int[183][];


        public hands()
        {
            TextWriter TW = new StreamWriter("table.txt");
            int value = 0;
            for(int i=0;i<183;i++)
            {
                if (i == 100)
                {
                    value += 14;
                }
                Boolean increment = false;
                HAND_TABLE[i] = new int[13];
                for (int j = 0; j < 13; j++)
                {
                    //high Card
                    if(i==0){
                        value++;
                        HAND_TABLE[i][j] = value;
                    }
                    //Pair
                    if (i >= 1 && i <= 13)
                    {
                        value++;
                        HAND_TABLE[i][j] = value;
                    }
                    //two pair
                    if (i >= 14 && i <= 80)
                    {
                        value++;
                        HAND_TABLE[i][j] = value;
                    }
                    //triple
                    if (i >= 81 && i <= 94)
                    {
                        increment = true;
                        HAND_TABLE[i][j] = value;
                    }
                    //straight
                    if (i >= 95 && i <= 101)
                    {
                        increment = true;
                        HAND_TABLE[i][j] = value;
                    }
                    //flush = 13 types
                    //Full House
                    //Console.WriteLine(value);
                    if (i >= 102 && i <= 168)
                    {
                        increment = true;
                        HAND_TABLE[i][j] = value;
                    }
                    //Quad
                    if (i >= 169 && i <= 182)
                    {
                        increment = true;
                        HAND_TABLE[i][j] = value;
                    }
                    TW.Write(value+" , ");

                }
                if (increment)
                {
                    value++;
                    increment = false;
                }
                TW.WriteLine();
            }
            TW.Close();

        }

        private int hasPair(int card1, int card2, int card3, int card4, int card5)
        {
            int value = -1;
            int[] card_array = new int[] { card1, card2, card3, card4, card5 };
            for(int i=0;i<5;i++)
            {
                for (int j = i + 1; j < 5; j++)
                {
                    if (card_array[i] == card_array[j])
                    {
                        return card_array[i];
                    }
                }
            }

            return value;
        }
        private int hasTriple(int card1, int card2, int card3, int card4, int card5)
        {
            int value = -1;
            int[] card_array = new int[] { card1, card2, card3, card4, card5 };
            Boolean found_one = false;
            for (int i = 0; i < 5; i++)
            {
                for (int j = i + 1; j < 5; j++)
                {
                    if (card_array[i] == card_array[j] && found_one)
                    {
                        return card_array[i];
                    }
                    if (card_array[i] == card_array[j] && !found_one)
                    {
                        found_one = true;
                    }
                }
            }

            return value;
        }
        private int[] hasTwoPair(int card1, int card2, int card3, int card4, int card5)
        {
            int[] value =new int[] {-1,-1};
            int[] card_array = new int[] { card1, card2, card3, card4, card5 };
            int pair1 = 0;
            for (int i = 0; i < 5; i++)
            {
                for (int j = i + 1; j < 5; j++)
                {
                    if (card_array[i] == card_array[j])
                    {
                        pair1 = card_array[i];
                    }
                }
            }
            for (int i = 0; i < 5; i++)
            {
                for (int j = i + 1; j < 5; j++)
                {
                    if (card_array[i] == card_array[j] && card_array[i] != pair1)
                    {
                        return new int[] {pair1,card_array[i]};
                    }
                }
            }

            return value;
        }
        private int[] hasFullHouse(int card1, int card2, int card3, int card4, int card5)
        {
            int[] value =new int[] {-1,-1};
            int[] card_array = new int[] { card1, card2, card3, card4, card5 };
            int pair1 = 0;
            Boolean found_one = false;
            for (int i = 0; i < 5; i++)
            {
                for (int j = i + 1; j < 5; j++)
                {
                    if (card_array[i] == card_array[j])
                    {
                        pair1 = card_array[i];
                    }
                }
            }
            for (int i = 0; i < 5; i++)
            {
                for (int j = i + 1; j < 5; j++)
                {
                    if (card_array[i] == card_array[j] && found_one && card_array[i] != pair1)
                    {
                        return new int[] {pair1,card_array[i]};
                    }
                    if (card_array[i] == card_array[j] && !found_one && card_array[i] != pair1)
                    {
                        found_one = true;
                    }
                }
            }

            return value;
        }
        private int hasQuad(int card1, int card2, int card3, int card4, int card5)
        {
            int value = -1;
            int[] card_array = new int[] { card1, card2, card3, card4, card5 };
            Boolean found_one = false;
            Boolean found_two = false;
            for (int i = 0; i < 5; i++)
            {
                for (int j = i + 1; j < 5; j++)
                {
                    if (card_array[i] == card_array[j] && found_one && found_two)
                    {
                        return card_array[i];
                    }
                    if (card_array[i] == card_array[j] && found_one && !found_two)
                    {
                        found_two = true;
                    }
                    if (card_array[i] == card_array[j] && !found_one && !found_two)
                    {
                        found_one = true;
                    }
                }
            }

            return value;
        }
        private int hasStraight(int card1, int card2, int card3, int card4, int card5)
        {
            int value = 1 ;
            int[] card_array = new int[] { card1, card2, card3, card4, card5 };
            Array.Sort<int>(card_array);
            int previous = card_array[0];
            for (int i = 1; i < 5; i++)
            {
                if (card_array[i] - 1 == previous)
                {
                    value = card_array[i];
                }
                else
                {
                    value=-1;
                }
            }
            card_array = rotate(card_array);
            for (int i = 1; i < 5; i++)
            {
                if (card_array[i] - 1 == previous)
                {
                    value = card_array[i];
                }
                else
                {
                    value=-1;
                }
            }
            return value;
        }
        private int[] rotate(int[] array)
        {
            int[] newarray = array;
            for (int i = 0; i < array.Length - 2; i++)
            {
                newarray[i] = array[i + 1];
            }
            newarray[array.Length - 1] = array[0];
            return newarray;
        }
        private int getHighCard(int card1, int card2, int card3, int card4, int card5){
            int[] card_array = new int[] { card1, card2, card3, card4, card5 };
            Array.Sort(card_array);
            return card_array[4];
        }
        private int getQuadScore(int HighCard,int Type)
        {
            int offset = QUAD_OFFSET;
            return HAND_TABLE[offset+Type-1][HighCard-1];
        }
        private int getTripleScore(int HighCard,int Type)
        {
            int offset = TRIPLE_OFFSET;
            return HAND_TABLE[offset+Type-1][HighCard-1];
        }
        private int getPairScore(int HighCard,int Type)
        {
            int offset = PAIR_OFFSET;
            return HAND_TABLE[offset+Type-1][HighCard-1];
        }
        private int getTwoPairScore(int HighCard,int Type1, int Type2)
        {
            int offset = TWO_PAIR_OFFSET;
            return HAND_TABLE[offset + (Type1 - 1) * (Type2 - 1)][HighCard - 1];
        }
        private int getFullHouseScore(int HighCard,int Type1,int Type2)
        {
            int offset = FULL_HOUSE_OFFSET;
            return HAND_TABLE[offset + (Type1 - 1) * (Type2 - 1)][HighCard - 1];
        }
        private int getStraightScore(int HighCard, int Type)
        {
            int offset = STRAIGHT_OFFSET;
            return HAND_TABLE[offset + Type-1][HighCard-1];
        }

        private int getScore(int card1, int card2, int card3, int card4, int card5)
        {
            int isPair, isTriple, isStraight, isQuad = -1;
            int[] isTwoPair, isFullHouse = new int[] {-1,-1};
            isPair = hasPair(card1, card2, card3, card4, card5);
            isTriple = hasTriple(card1, card2, card3, card4, card5);
            isTwoPair = hasTwoPair(card1, card2, card3, card4, card5);
            isStraight = hasStraight(card1, card2, card3, card4, card5);
            isQuad = hasQuad(card1, card2, card3, card4, card5);
            isFullHouse = hasFullHouse(card1, card2, card3, card4, card5);
            //Console.WriteLine(isPair + ", " + isTriple + ", " + isQuad + ", " + isStraight);
            if (isQuad > 0)
            {
                return getQuadScore(getHighCard(card1, card2, card3, card4, card5), isQuad);
            }
            if (isStraight > 0)
            {
                return getStraightScore(getHighCard(card1, card2, card3, card4, card5), isStraight);
            }
            if (isFullHouse[0] > 0)
            {
                return getFullHouseScore(getHighCard(card1, card2, card3, card4, card5), isFullHouse[0], isFullHouse[1]);
            }
            if (isTriple > 0)
            {
                return getTripleScore(getHighCard(card1, card2, card3, card4, card5), isTriple);
            }
            if (isTwoPair[0] > 0)
            {
                return getTwoPairScore(getHighCard(card1, card2, card3, card4, card5), isTwoPair[0], isTwoPair[1]);
            }
            if (isPair > 0)
            {
                return getPairScore(getHighCard(card1, card2, card3, card4, card5), isPair);
            }
            else
            {
                return HAND_TABLE[0][getHighCard(card1, card2, card3, card4, card5)-1];
            }
        }

        private int removeSuit(int card)
        {
            if (card == 0 || card == 13 || card == 26 || card == 39)
            {
                return 1;
            }
            if (card == 1 || card == 14 || card == 27 || card == 40)
            {
                return 2;
            }
            if (card == 2 || card == 15 || card == 28 || card == 41)
            {
                return 3;
            }
            if (card == 3 || card == 16 || card == 29 || card == 42)
            {
                return 4;
            }
            if (card == 4 || card == 17 || card == 30 || card == 43)
            {
                return 5;
            }
            if (card == 5 || card == 18 || card == 31 || card == 44)
            {
                return 6;
            }
            if (card == 6 || card == 19 || card == 32 || card == 45)
            {
                return 7;
            }
            if (card == 7 || card == 20 || card == 33 || card == 46)
            {
                return 8;
            }
            if (card == 8 || card == 21 || card == 34 || card == 47)
            {
                return 9;
            }
            if (card == 9 || card == 22 || card == 35 || card == 48)
            {
                return 10;
            }
            if (card == 10 || card == 23 || card == 36 || card == 49)
            {
                return 11;
            }
            if (card == 11 || card == 24 || card == 37 || card == 50)
            {
                return 12;
            }
            if (card == 12 || card == 25 || card == 38 || card == 51)
            {
                return 13;
            }
            return card;
        }

        private Boolean isFlush(int card1, int card2, int card3, int card4, int card5)
        {
            int[] suit1 = new int[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };
            int[] suit2 = new int[] { 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 };
            int[] suit3 = new int[] { 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38 };
            int[] suit4 = new int[] { 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51 };

            int[] hand = new int[] { card1, card2, card3, card4, card5 };

            if (suit1.Intersect(hand).Count() == 5)
            {
                return true;
            }
            if (suit2.Intersect(hand).Count() == 5)
            {
                return true;
            }
            if (suit3.Intersect(hand).Count() == 5)
            {
                return true;
            }
            if (suit4.Intersect(hand).Count() == 5)
            {
                return true;
            }
            return false;
        }

        public int evaluateHand(int card1, int card2, int card3, int card4, int card5)
        {
            //do flush stuff
            if (isFlush(card1, card2, card3, card4, card5))
            {
                card1 = removeSuit(card1);
                card2 = removeSuit(card2);
                card3 = removeSuit(card3);
                card4 = removeSuit(card4);
                card5 = removeSuit(card5);
                int max = hasStraight(card1, card2, card3, card4, card5);
                if (max > 0)
                {
                    return STRAIGHT_FLUSH + getHighCard(card1, card2, card3, card4, card5);
                }
                else
                {
                    return 101 + getHighCard(card1, card2, card3, card4, card5);
                }

            }
            card1 = removeSuit(card1);
            card2 = removeSuit(card2);
            card3 = removeSuit(card3);
            card4 = removeSuit(card4);
            card5 = removeSuit(card5);
            return getScore(card1, card2, card3, card4, card5);
        }
    }
    
    class deck
    {
        private Stack<int> cards;
        private LinkedList<int> cardlist;
        public deck()
        {
            this.cardlist = new LinkedList<int>();
            this.cards = new Stack<int>();

            for (int i = 0; i < 52; i++)
            {
                this.cardlist.AddLast(i);
            }
            this.shuffle();
        }

        public void shuffle()
        {
            Random R = new Random();
            this.cards.Clear();
            for (int i = 0; i < this.cardlist.Count; i++)
            {
                int a = this.cardlist.Count > 1 ? R.Next(this.cardlist.Count - 1) : 0;
                int cd = this.cardlist.ElementAt(a);
                this.cardlist.Remove(cd);
                this.cards.Push(cd);
            }
            for (int i = 0; i < 52; i++)
            {
                this.cardlist.AddLast(i);
            }
        }

        public int draw()
        {
            return cards.Pop();
        }
        public void removeCard(int card)
        {
            this.cardlist.Remove(card);
        }
    }
    class Playout
    {
        private const int NUM_PLAYOUT = 3000;
        private const float MAX_TIME = 3000.00f;
        private hands H = new hands();
    /*    static void Main(string[] args)
        {
            TextWriter TW = new StreamWriter("scores.txt");
            Playout P = new Playout();
            for (int c1 = 0; c1 < 52; c1++)
            {
                for (int c2 = c1 + 1; c2 < 52; c2++)
                {
                    TW.WriteLine(c1 + ", " + c2 + ", " + P.playout(c1, c2).ToString());
                }
            }
            TW.Close();

        }

     */
        public int playout(int card_one, int card_two)
        {
            int score = 0;
            deck d = new deck();
            int number_plays = 0;
            DateTime start = DateTime.Now;
            DateTime end = DateTime.Now;
            for (; ; )
            {
                d.removeCard(card_one-1);
                d.removeCard(card_two-1);
                d.shuffle();
                score += this.score(card_one-1, card_two-1, d.draw(), d.draw(), d.draw(), d.draw(), d.draw());
                end = DateTime.Now;
                number_plays++;
                TimeSpan Duration = end - start;
                if (Duration.TotalMilliseconds > MAX_TIME)
                {
                    break;
                }
            }

            return score / number_plays;
        }
        public int playout(int card_one, int card_two, int card_three, int card_four, int card_five)
        {
            int score = 0;
            deck d = new deck();
            DateTime start = DateTime.Now;
            int number_plays = 0;
            DateTime end = DateTime.Now;
            for (; ; )
            {
                d.removeCard(card_one-1);
                d.removeCard(card_two - 1);
                d.removeCard(card_three - 1);
                d.removeCard(card_four - 1);
                d.removeCard(card_five - 1);
                d.shuffle();
                score += this.score(card_one - 1, card_two - 1, card_three - 1, card_four - 1, card_five - 1, d.draw(), d.draw());
                number_plays ++;
                end = DateTime.Now;
                TimeSpan Duration = end - start;
                if (Duration.TotalMilliseconds > MAX_TIME)
                {
                    break;
                }
            }

            return score / number_plays;
        }
        public int playout(int card_one, int card_two, int card_three, int card_four, int card_five, int card_six)
        {
            int score = 0;
            int number_plays = 0;
            deck d = new deck();
            DateTime start = DateTime.Now;
            DateTime end = DateTime.Now;
            for (; ; )
            {
                d.removeCard(card_one-1);
                d.removeCard(card_two-1);
                d.removeCard(card_three-1);
                d.removeCard(card_four-1);
                d.removeCard(card_five-1);
                d.removeCard(card_six-1);
                d.shuffle();
                score += this.score(card_one-1, card_two-1, card_three-1, card_four-1, card_five-1, card_six-1, d.draw());
                end = DateTime.Now;
                number_plays++;
                TimeSpan Duration = end - start;
                if (Duration.TotalMilliseconds > MAX_TIME)
                {
                    break;
                }
            }

            return score / number_plays;
        }
        public static void PrintIndexAndValues(int[] myArr)
        {
            for (int i = 0; i < myArr.Length; i++)
            {
                Console.WriteLine("   [{0}] : {1}", i, myArr[i]);
            }
            Console.WriteLine();
        }
        public int score(int card_one, int card_two, int card_three, int card_four, int card_five, int card_six, int card_seven)
        {
            //Console.WriteLine("Evaluating Hand: " + card1 + " , " + card2 + " , " + card3 + " , " + card4 + " , " + card5);

            int[] scores = new int[21];
            scores[0] = H.evaluateHand(card_one, card_two, card_three, card_four, card_five);
            scores[1] = H.evaluateHand(card_one, card_two, card_three, card_four, card_six);
            scores[2] = H.evaluateHand(card_one, card_two, card_three, card_four, card_seven);
            scores[3] = H.evaluateHand(card_one, card_two, card_three, card_six, card_five);
            scores[4] = H.evaluateHand(card_one, card_two, card_three, card_seven, card_five);
            scores[5] = H.evaluateHand(card_one, card_two, card_six, card_four, card_five);
            scores[6] = H.evaluateHand(card_one, card_two, card_seven, card_four, card_five);
            scores[7] = H.evaluateHand(card_one, card_six, card_three, card_four, card_five);
            scores[8] = H.evaluateHand(card_one, card_seven, card_three, card_four, card_five);
            scores[9] = H.evaluateHand(card_six, card_two, card_three, card_four, card_five);
            scores[10] = H.evaluateHand(card_seven, card_two, card_three, card_four, card_five);
            scores[11] = H.evaluateHand(card_one, card_two, card_three, card_six, card_seven);
            scores[12] = H.evaluateHand(card_one, card_two, card_six, card_seven, card_five);
            scores[13] = H.evaluateHand(card_one, card_six, card_seven, card_four, card_five);
            scores[14] = H.evaluateHand(card_six, card_seven, card_three, card_four, card_five);
            scores[15] = H.evaluateHand(card_seven, card_two, card_three, card_four, card_six);
            scores[16] = H.evaluateHand(card_six, card_two, card_seven, card_four, card_five);
            scores[17] = H.evaluateHand(card_six, card_two, card_three, card_seven, card_five);
            scores[18] = H.evaluateHand(card_one, card_six, card_three, card_seven, card_five);
            scores[19] = H.evaluateHand(card_one, card_six, card_three, card_four, card_seven);
            scores[20] = H.evaluateHand(card_one, card_two, card_six, card_four, card_seven);
            //PrintIndexAndValues(scores);
            Array.Sort(scores);
            //PrintIndexAndValues(scores);
            return scores[20];
        }
    }
    

}
