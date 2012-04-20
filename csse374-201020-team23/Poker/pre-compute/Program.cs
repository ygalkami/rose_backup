using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace pre_compute
{

    class deck
    {
        Stack<int> cards;
        LinkedList<int> cardlist;
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
    class Program
    {
        public const int NUM_PLAYOUT = 3000;
        public const float MAX_TIME = 3000.00f;
        hands H = new hands();
        static void Main(string[] args)
        {
            TextWriter TW = new StreamWriter("scores.txt");
            Program P = new Program();
            for (int c1 = 0; c1 < 52; c1++)
            {
                for (int c2 = c1 + 1; c2 < 52; c2++)
                {
                    TW.WriteLine(c1 + ", " + c2 + ", " + P.playout(c1, c2).ToString());
                }
            }
            TW.Close();

        }

        private int playout(int card_one, int card_two)
        {
            int score = 0;
            deck d = new deck();
            for (int i = 0; i <= NUM_PLAYOUT; i++)
            {
                d.removeCard(card_one);
                d.removeCard(card_two);
                d.shuffle();
                score += this.score(card_one, card_two, d.draw(), d.draw(), d.draw(), d.draw(), d.draw());
            }

            return score / NUM_PLAYOUT;
        }
        private int playout(int card_one, int card_two, int card_three, int card_four, int card_five)
        {
            int score = 0;
            deck d = new deck();
            DateTime start = DateTime.Now;
            DateTime end = DateTime.Now;
            for (; ; )
            {
                score += this.score(card_one, card_two, card_three, card_four, card_five, d.draw(), d.draw());
                d.shuffle();
                end = DateTime.Now;
                TimeSpan Duration = end - start;
                if (Duration.TotalMilliseconds > MAX_TIME)
                {
                    break;
                }
            }

            return score / NUM_PLAYOUT;
        }
        private int playout(int card_one, int card_two, int card_three, int card_four, int card_five, int card_six)
        {
            int score = 0;
            deck d = new deck();
            DateTime start = DateTime.Now;
            DateTime end = DateTime.Now;
            for (; ; )
            {
                score += this.score(card_one, card_two, card_three, card_four, card_five, card_six, d.draw());
                d.shuffle();
                end = DateTime.Now;
                TimeSpan Duration = end - start;
                if (Duration.TotalMilliseconds > MAX_TIME)
                {
                    break;
                }
            }

            return score / NUM_PLAYOUT;
        }
        public static void PrintIndexAndValues(int[] myArr)
        {
            for (int i = 0; i < myArr.Length; i++)
            {
                Console.WriteLine("   [{0}] : {1}", i, myArr[i]);
            }
            Console.WriteLine();
        }
        private int score(int card1, int card2, int card3, int card4, int card5, int card6, int card7)
        {
            //Console.WriteLine("Evaluating Hand: " + card1 + " , " + card2 + " , " + card3 + " , " + card4 + " , " + card5);
            int[] scores = new int[21];
            scores[0] = H.EvaluateHand(card1, card2, card3, card4, card5);
            scores[1] = H.EvaluateHand(card1, card2, card3, card4, card6);
            scores[2] = H.EvaluateHand(card1, card2, card3, card4, card7);
            scores[3] = H.EvaluateHand(card1, card2, card3, card6, card5);
            scores[4] = H.EvaluateHand(card1, card2, card3, card7, card5);
            scores[5] = H.EvaluateHand(card1, card2, card6, card4, card5);
            scores[6] = H.EvaluateHand(card1, card2, card7, card4, card5);
            scores[7] = H.EvaluateHand(card1, card6, card3, card4, card5);
            scores[8] = H.EvaluateHand(card1, card7, card3, card4, card5);
            scores[9] = H.EvaluateHand(card6, card2, card3, card4, card5);
            scores[10] = H.EvaluateHand(card7, card2, card3, card4, card5);
            scores[11] = H.EvaluateHand(card1, card2, card3, card6, card7);
            scores[12] = H.EvaluateHand(card1, card2, card6, card7, card5);
            scores[13] = H.EvaluateHand(card1, card6, card7, card4, card5);
            scores[14] = H.EvaluateHand(card6, card7, card3, card4, card5);
            scores[15] = H.EvaluateHand(card7, card2, card3, card4, card6);
            scores[16] = H.EvaluateHand(card6, card2, card7, card4, card5);
            scores[17] = H.EvaluateHand(card6, card2, card3, card7, card5);
            scores[18] = H.EvaluateHand(card1, card6, card3, card7, card5);
            scores[19] = H.EvaluateHand(card1, card6, card3, card4, card7);
            scores[20] = H.EvaluateHand(card1, card2, card6, card4, card7);
            //PrintIndexAndValues(scores);
            Array.Sort(scores);
            //PrintIndexAndValues(scores);
            return scores[20];
        }
    }
    
}
