using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Media.Animation;
using System.Collections;
using System.Windows.Threading;
using System.Threading;

namespace Poker
{
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window, IGameObserver, IMoveChoiceStrategy
	{
		private GameController game;
		private bool gameCreated;
		private bool humanIsPlaying;
		private Dictionary<PlayerPosition, int> cardsDealtSoFar;
		private Dictionary<PlayerPosition, bool> flippedCardPositions;

        private delegate void NoArgDelegate();
        private delegate Move ReturnDelegate(List<Move> legalMoves);

		public MainWindow()
		{
			InitializeComponent();
			this.gameCreated = false;
			this.cardsDealtSoFar = new Dictionary<PlayerPosition, int>();
			this.flippedCardPositions = new Dictionary<PlayerPosition, bool>();

		}



		private void startButton_Click(object sender, RoutedEventArgs e)
		{
			if (!gameCreated)
			{
				MessageBoxResult result;
				result = MessageBox.Show("Would you like to play in the game?", "Participation Option", MessageBoxButton.YesNo);
				if (result == MessageBoxResult.Yes)
				{
					this.humanIsPlaying = true;
					this.game = new GameController(3, this);
				}
				else
				{
					this.humanIsPlaying = false;
					this.game = new GameController(2, this);
				}
				this.game.addGameObserver(this);
				this.initializeGame();

                // Start the game
                NoArgDelegate mainGameDel = new NoArgDelegate(this.game.beginGame);
                mainGameDel.BeginInvoke(null, null);

			}
			else 
			{
                this.initializeGame();
                
                NoArgDelegate repeatedGameDel = new NoArgDelegate(this.game.playAgain);
                repeatedGameDel.BeginInvoke(null, null);

			}
		}


		/*
		 * IGameObserver Methods
		 */
		public void cardDealt(PlayerPosition position, Card card)
		{
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action( delegate(){
			switch (position)
			{
				case PlayerPosition.Right:
					if (cardsDealtSoFar[PlayerPosition.Right] == 0)
					{
						moveCard(RightCard1, 950, 425);
						cardsDealtSoFar[PlayerPosition.Right] = 1;
						if (flippedCardPositions[PlayerPosition.Right])
						{
							changeImage(RightCard1, card);
						}
					}
					else
					{
						moveCard(RightCard2, 1050, 425);
						cardsDealtSoFar[PlayerPosition.Right] = 2;
						if (flippedCardPositions[PlayerPosition.Right])
						{
							changeImage(RightCard2, card);
						}
					}

					break;
				case PlayerPosition.Middle:
					{
						if (cardsDealtSoFar[PlayerPosition.Middle] == 0)
						{
							moveCard(MiddleCard1, 500, 425);
							cardsDealtSoFar[PlayerPosition.Middle] = 1;
							if (flippedCardPositions[PlayerPosition.Middle])
							{
								changeImage(MiddleCard1, card);
							}
						}
						else
						{
							moveCard(MiddleCard2, 600, 425);
							cardsDealtSoFar[PlayerPosition.Middle] = 2;
							if (flippedCardPositions[PlayerPosition.Middle])
							{
								changeImage(MiddleCard2, card);
							}
						}
						break;
					}
				case PlayerPosition.Left:
					{
						if (cardsDealtSoFar[PlayerPosition.Left] == 0)
						{
							moveCard(LeftCard1, 50, 425);
							cardsDealtSoFar[PlayerPosition.Left] = 1;
							if (flippedCardPositions[PlayerPosition.Left])
							{
								changeImage(LeftCard1, card);
							}
						}
						else 
						{
							moveCard(LeftCard2, 150, 425);
							cardsDealtSoFar[PlayerPosition.Left] = 2;
							if (flippedCardPositions[PlayerPosition.Left])
							{
								changeImage(LeftCard2, card);
							}
						}

						break;
					}
				case PlayerPosition.Top:
					{
						if (cardsDealtSoFar[PlayerPosition.Top] == 0)
						{
							moveCard(dealerCard1, 350, 20);
							cardsDealtSoFar[PlayerPosition.Top] = 1;
							changeImage(dealerCard1, card);
						}
						else if (cardsDealtSoFar[PlayerPosition.Top] == 1)
						{
							moveCard(dealerCard2, 450, 20);
							cardsDealtSoFar[PlayerPosition.Top] = 2;
							changeImage(dealerCard2, card);
						}
						else if (cardsDealtSoFar[PlayerPosition.Top] == 2)
						{
							moveCard(dealerCard3, 550, 20);
							cardsDealtSoFar[PlayerPosition.Top] = 3;
							changeImage(dealerCard3, card);
						}
						else if (cardsDealtSoFar[PlayerPosition.Top] == 3)
						{
							moveCard(dealerCard4, 650, 20);
							cardsDealtSoFar[PlayerPosition.Top] = 4;
							changeImage(dealerCard4, card);
						}
						else
						{
							moveCard(dealerCard5, 750, 20);
							cardsDealtSoFar[PlayerPosition.Top] = 5;
							changeImage(dealerCard5, card);
						}
						break;
					}
				default:
					new Exception("Invalid selection of card to deal.");
					break;
			}
            }));

		}
		public void stackUpdated(PlayerPosition position, int stackValue)
		{
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action(delegate()
            {
                switch (position)
                {
                    case PlayerPosition.Right:
                        RightLabel.Text = stackValue.ToString();
                        break;
                    case PlayerPosition.Middle:
                        MiddleLabel.Text = stackValue.ToString();
                        break;
                    case PlayerPosition.Left:
                        LeftLabel.Text = stackValue.ToString();
                        break;
                    default:
                        new Exception("Tried to update a stack that doesn't exist");
                        break;
                }
            }));

		}
		public void potUpdated(int potValue)
		{
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action(delegate()
            {
                potLabel.Text = potValue.ToString();
            }));
		}
		public void playerRaised(PlayerPosition position, int potValue, int stackValue, int raiseAmount)
		{
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action( delegate(){
			switch (position)
			{
				case PlayerPosition.Right:
					RightLabel.Text = stackValue.ToString();
					break;
				case PlayerPosition.Middle:
					MiddleLabel.Text = stackValue.ToString();
					break;
				case PlayerPosition.Left:
					LeftLabel.Text = stackValue.ToString();
					break;
				default:
					throw new Exception("Tried to update a player that doesn't exist.");
			}
			potLabel.Text = potValue.ToString();
			addToTextDisplay(String.Concat(position.ToString(), " raised by ", raiseAmount.ToString(), "\n"));
            }));
		}
		public void playerCalled(PlayerPosition position, int potValue, int stackValue)
		{
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action(delegate()
            {
                switch (position)
                {
                    case PlayerPosition.Right:
                        RightLabel.Text = stackValue.ToString();
                        break;
                    case PlayerPosition.Middle:
                        MiddleLabel.Text = stackValue.ToString();
                        break;
                    case PlayerPosition.Left:
                        LeftLabel.Text = stackValue.ToString();
                        break;
                    default:
                        throw new Exception("Tried to update a player that doesn't exist.");
                }
                potLabel.Text = potValue.ToString();
                addToTextDisplay(String.Concat(position.ToString(), " called\n"));
            }));
		}
		public void playerChecked(PlayerPosition position)
		{
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action(delegate()
            {
                addToTextDisplay(String.Concat(position.ToString(), " checked\n"));
            }));
		}
		public void playerFolded(PlayerPosition position)
		{
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action(delegate()
            {
                addToTextDisplay(String.Concat(position.ToString(), " folded\n"));
            }));
		}
		public void dealStateEnded(DealState state)
		{
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action(delegate()
            {
                if (state is PreFlopState)
                {
                    addToTextDisplay("Preflop has ended.\n");
                }
                else if (state is FlopState)
                {
                    addToTextDisplay("Flop has ended.\n");
                }
                else if (state is TurnState)
                {
                    addToTextDisplay("Turn has ended.\n");
                }
                else if (state is RiverState)
                {
                    addToTextDisplay("River has ended.\n");
                }
                else
                {
                    addToTextDisplay("Showdown has ended.\n");
                    startButton.Visibility = System.Windows.Visibility.Hidden;
                }
            }));
		}
        public void playerWon(PlayerPosition position, int amount)
        {
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action(delegate()
            {
                addToTextDisplay(String.Concat(position.ToString(), " won ", amount.ToString(), ".\n"));
            }));
        
        }
		public void gameEnded()
		{
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action(delegate()
            {
                this.startButton.Content = "Play Again";
                this.startButton.Visibility = System.Windows.Visibility.Visible;
                if (humanIsPlaying)
                {
                    changeImage(RightCard1, this.game.players[0].cards[0]);
                    changeImage(RightCard2, this.game.players[0].cards[1]);
                    changeImage(LeftCard1, this.game.players[2].cards[0]);
                    changeImage(LeftCard2, this.game.players[2].cards[1]);
                }
            }));

		}
        public void gameReset()
        {
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action(delegate()
            {
                Uri cardBackUri = new Uri(@"/Images/cards/cardback.png", UriKind.RelativeOrAbsolute);

                moveCard(dealerCard1, 25, 50);
                moveCard(dealerCard2, 25, 50);
                moveCard(dealerCard3, 25, 50);
                moveCard(dealerCard4, 25, 50);
                moveCard(dealerCard5, 25, 50);

                dealerCard1.Source = new BitmapImage(cardBackUri);
                dealerCard2.Source = new BitmapImage(cardBackUri);
                dealerCard3.Source = new BitmapImage(cardBackUri);
                dealerCard4.Source = new BitmapImage(cardBackUri);
                dealerCard5.Source = new BitmapImage(cardBackUri);

                RightCard1.Source = new BitmapImage(cardBackUri);
                RightCard2.Source = new BitmapImage(cardBackUri);
                MiddleCard1.Source = new BitmapImage(cardBackUri);
                MiddleCard2.Source = new BitmapImage(cardBackUri);
                LeftCard1.Source = new BitmapImage(cardBackUri);
                LeftCard2.Source = new BitmapImage(cardBackUri);

                moveCard(RightCard1, 25, 50);
                moveCard(RightCard2, 25, 50);
                moveCard(MiddleCard1, 25, 50);
                moveCard(MiddleCard2, 25, 50);
                moveCard(LeftCard1, 25, 50);
                moveCard(LeftCard2, 25, 50);

                textBox.Text = "";
                this.startButton.Visibility = System.Windows.Visibility.Hidden;
            }));
        }
        public void playersOutOfMoney()
        {
            MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new Action(delegate()
            {
                MessageBox.Show("The players are out of money.", "Game Complete" ,MessageBoxButton.OK);
            }));
        }

		/*
		 * IMoveChooser Methods
		 */
		public Move getMove(DealState currentDealState, List<Move> legalMoves, Card[] cards)
		{
            return (Move)MainGrid.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Normal, new ReturnDelegate(delegate(List<Move> movesOptions)
            {
                Move myMove = null;
                MoveDialogBox moveChoiceBox = new MoveDialogBox(legalMoves);
                moveChoiceBox.Owner = this;
                moveChoiceBox.ShowDialog();
                if (moveChoiceBox.DialogResult == true)
                {
                    myMove = moveChoiceBox.moveChoice;
                }
                else
                {
                    new Exception("User did not select move.");
                }
                return myMove;
            }), legalMoves);
		}

        /*
         * Helper Methods
         */
        private void initializeGame()
        {
            this.gameCreated = true;
            this.initializeCardsDealtInPositions();
            this.initializeFlippedCardPositions();
    
            this.textBox.Text = "";
            this.startButton.Visibility = System.Windows.Visibility.Hidden;

            if (humanIsPlaying == true)
            {
                rightMoneyLabel.Visibility = System.Windows.Visibility.Visible;
                middleMoneyLabel.Visibility = System.Windows.Visibility.Visible;
                leftMoneyLabel.Visibility = System.Windows.Visibility.Visible;
            }
            else
            {
                rightMoneyLabel.Visibility = System.Windows.Visibility.Visible;
                leftMoneyLabel.Visibility = System.Windows.Visibility.Visible;
            }
        }
        private void initializeCardsDealtInPositions()
        {
            this.cardsDealtSoFar.Clear();
            this.cardsDealtSoFar.Add(PlayerPosition.Right, 0);
            this.cardsDealtSoFar.Add(PlayerPosition.Middle, 0);
            this.cardsDealtSoFar.Add(PlayerPosition.Left, 0);
            this.cardsDealtSoFar.Add(PlayerPosition.Top, 0);
        }
        private void initializeFlippedCardPositions()
        {
            this.flippedCardPositions.Clear();
            if (this.humanIsPlaying)
            {
                this.flippedCardPositions.Add(PlayerPosition.Right, false);
                this.flippedCardPositions.Add(PlayerPosition.Middle, true);
                this.flippedCardPositions.Add(PlayerPosition.Left, false);
                this.flippedCardPositions.Add(PlayerPosition.Top, true);
            }
            else
            {
                this.flippedCardPositions.Add(PlayerPosition.Right, true);
                this.flippedCardPositions.Add(PlayerPosition.Middle, false);
                this.flippedCardPositions.Add(PlayerPosition.Left, true);
                this.flippedCardPositions.Add(PlayerPosition.Top, true);
            }
        }

		/*
		 * Animation Helper Methods
		 */
		private void moveCard(Image cardImage, int absoluteX, int absoluteY)
		{
                string transformName = "theTransform";
                int x = absoluteX - (int)cardImage.Margin.Left;
                int y = absoluteY - (int)cardImage.Margin.Top;

                if (x != 0 && y != 0)
                {
                    //create translateTransform
                    TranslateTransform moveCard9 = new TranslateTransform();
                    this.RegisterName(transformName, moveCard9);
                    cardImage.RenderTransform = moveCard9;

                    //create the path
                    PathGeometry animationPath9 = new PathGeometry();
                    PathFigure pFigure9 = new PathFigure();
                    pFigure9.StartPoint = new Point(0, 0);
                    PolyBezierSegment pBezierSegment9 = new PolyBezierSegment();
                    pBezierSegment9.Points.Add(new Point(x, y));
                    pBezierSegment9.Points.Add(new Point(x, y));
                    pBezierSegment9.Points.Add(new Point(x, y));
                    pFigure9.Segments.Add(pBezierSegment9);
                    animationPath9.Figures.Add(pFigure9);

                    //freeze path for performance benefits
                    animationPath9.Freeze();

                    //create the animation to move the card horizontally
                    DoubleAnimationUsingPath translateXAnimation9 = new DoubleAnimationUsingPath();
                    translateXAnimation9.PathGeometry = animationPath9;
                    translateXAnimation9.Duration = TimeSpan.FromSeconds(1);
                    translateXAnimation9.Source = PathAnimationSource.X;

                    Storyboard.SetTargetName(translateXAnimation9, transformName);
                    Storyboard.SetTargetProperty(translateXAnimation9, new PropertyPath(TranslateTransform.XProperty));

                    //create the animation to move the card vertically
                    DoubleAnimationUsingPath translateYAnimation9 = new DoubleAnimationUsingPath();
                    translateYAnimation9.PathGeometry = animationPath9;
                    translateYAnimation9.Duration = TimeSpan.FromSeconds(1);
                    translateYAnimation9.Source = PathAnimationSource.Y;

                    Storyboard.SetTargetName(translateYAnimation9, transformName);
                    Storyboard.SetTargetProperty(translateYAnimation9, new PropertyPath(TranslateTransform.YProperty));

                    //create a storyboard
                    Storyboard pathAnimationStoryboard = new Storyboard();
                    pathAnimationStoryboard.Children.Add(translateXAnimation9);
                    pathAnimationStoryboard.Children.Add(translateYAnimation9);

                    //begin the storyboard
                    pathAnimationStoryboard.Begin(this);
                    this.UnregisterName(transformName);
                }

		}
		private void changeImage(Image cardImage, Card card)
		{
            string imgSrc = card.getImageSource();
            cardImage.Source = new BitmapImage(new Uri(@imgSrc, UriKind.RelativeOrAbsolute));
		}
		private void addToTextDisplay(string textToAdd) 
		{
                textBox.Text = String.Concat(textBox.Text, textToAdd);

		}

	}
}
