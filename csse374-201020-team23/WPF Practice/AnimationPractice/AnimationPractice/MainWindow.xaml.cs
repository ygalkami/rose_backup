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
using System.IO;

namespace AnimationPractice
{
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window
	{
        int currentCardFromDeck = 52;
		public MainWindow()
		{
            //Double CARDPOSITION1X = 10;
            //Double CARDPOSITION1Y = 500;
			InitializeComponent();
		}

		private void button1_Click(object sender, RoutedEventArgs e)
		{
            button1.IsEnabled = false;
            for (int i = 52; i < currentCardFromDeck - 7; i--)
            {

                currentCardFromDeck--;
            }
            dealcards();

		/*	DoubleAnimation flip = new DoubleAnimation(0, new Duration(TimeSpan.FromSeconds(3)));

			ScaleTransform shrink = new ScaleTransform(-1,1);
			cardFront.RenderTransform = shrink;
			cardFront.BeginAnimation(ScaleTransform.ScaleXProperty, flip);

			DoubleAnimation move = new DoubleAnimation(cardFront.Width, new Duration(TimeSpan.FromSeconds(3)));
			TranslateTransform trans = new TranslateTransform(cardFront.Width, 0);
			cardFront.RenderTransform = trans;
			cardFront.BeginAnimation(TranslateTransform.XProperty, move);

			//cardFront.SourceUpdated +=new EventHandler<DataTransferEventArgs>(cardFront_SourceUpdated);
			//cardFront.Source = new BitmapImage(new Uri("C:/Users/jabonsa/Desktop/playingCards/clubs-2-150.png"));
            */
		}

        private void dealcards()
        {


            ////////////////////////////////////////////////
            //////// Deal card 1 ///////////////////////////
            ////////////////////////////////////////////////
            TranslateTransform moveCard9 = new TranslateTransform();
            this.RegisterName("AnimatedTranslateTransform", moveCard9);
            card9.RenderTransform = moveCard9;

            //create the path
            PathGeometry animationPath9 = new PathGeometry();
            PathFigure pFigure9 = new PathFigure();
            pFigure9.StartPoint = new Point(0, 0);
            PolyBezierSegment pBezierSegment9 = new PolyBezierSegment();
            pBezierSegment9.Points.Add(new Point(30, 350));
            pBezierSegment9.Points.Add(new Point(30, 350));
            pBezierSegment9.Points.Add(new Point(30, 350));
            pFigure9.Segments.Add(pBezierSegment9);
            animationPath9.Figures.Add(pFigure9);

            //freeze path for performance benefits
            animationPath9.Freeze();

            //create the animation to move the card horizontally
            DoubleAnimationUsingPath translateXAnimation9 = new DoubleAnimationUsingPath();
            translateXAnimation9.PathGeometry = animationPath9;
            translateXAnimation9.PathGeometry = animationPath9;
            translateXAnimation9.Duration = TimeSpan.FromSeconds(.5);

            //set source property to x
            translateXAnimation9.Source = PathAnimationSource.X;

            Storyboard.SetTargetName(translateXAnimation9, "AnimatedTranslateTransform");
            Storyboard.SetTargetProperty(translateXAnimation9, new PropertyPath(TranslateTransform.XProperty));

            DoubleAnimationUsingPath translateYAnimation9 = new DoubleAnimationUsingPath();
            translateYAnimation9.PathGeometry = animationPath9;
            translateYAnimation9.Duration = TimeSpan.FromSeconds(.5);

            translateYAnimation9.Source = PathAnimationSource.Y;

            Storyboard.SetTargetName(translateYAnimation9, "AnimatedTranslateTransform");
            Storyboard.SetTargetProperty(translateYAnimation9, new PropertyPath(TranslateTransform.YProperty));

            //create a storyboard
            Storyboard.SetTargetName(translateYAnimation9, "AnimatedTranslateTransform");
            Storyboard.SetTargetProperty(translateYAnimation9, new PropertyPath(TranslateTransform.YProperty));









            ////////////////////////////////////////////////
            //////// Deal card 2 ///////////////////////////
            ////////////////////////////////////////////////
            TranslateTransform moveCard8 = new TranslateTransform();
            this.RegisterName("AnimatedTranslateTransform8", moveCard8);
            card8.RenderTransform = moveCard8;

            //create the path
            PathGeometry animationPath8 = new PathGeometry();
            PathFigure pFigure8 = new PathFigure();
            pFigure8.StartPoint = new Point(0, 0);
            PolyBezierSegment pBezierSegment8 = new PolyBezierSegment();
            pBezierSegment8.Points.Add(new Point(130, 350));
            pBezierSegment8.Points.Add(new Point(130, 350));
            pBezierSegment8.Points.Add(new Point(130, 350));
            pFigure8.Segments.Add(pBezierSegment8);
           // animationPath8.Figures.Add(pFigure7);
            animationPath8.Figures.Add(pFigure8);

            //freeze path for performance benefits
            animationPath8.Freeze();

            //create the animation to move the card horizontally
            DoubleAnimationUsingPath translateXAnimation8 = new DoubleAnimationUsingPath();
            translateXAnimation8.PathGeometry = animationPath8;
            translateXAnimation8.PathGeometry = animationPath8;
            translateXAnimation8.Duration = TimeSpan.FromSeconds(.5);

            //set source property to x
            translateXAnimation8.Source = PathAnimationSource.X;

            Storyboard.SetTargetName(translateXAnimation8, "AnimatedTranslateTransform8");
            Storyboard.SetTargetProperty(translateXAnimation8, new PropertyPath(TranslateTransform.XProperty));

            DoubleAnimationUsingPath translateYAnimation8 = new DoubleAnimationUsingPath();
            translateYAnimation8.PathGeometry = animationPath8;
            translateYAnimation8.Duration = TimeSpan.FromSeconds(.5);

            translateYAnimation8.Source = PathAnimationSource.Y;

            Storyboard.SetTargetName(translateYAnimation8, "AnimatedTranslateTransform8");
            Storyboard.SetTargetProperty(translateYAnimation8, new PropertyPath(TranslateTransform.YProperty));

            //create a storyboard
            Storyboard.SetTargetName(translateYAnimation8, "AnimatedTranslateTransform8");
            Storyboard.SetTargetProperty(translateYAnimation8, new PropertyPath(TranslateTransform.YProperty));





            ////////////////////////////////////////////////
            //////// Deal card 3 ///////////////////////////
            ////////////////////////////////////////////////
            TranslateTransform moveCard7 = new TranslateTransform();
            this.RegisterName("AnimatedTranslateTransform7", moveCard7);
            card7.RenderTransform = moveCard7;

            //create the path
            PathGeometry animationPath7 = new PathGeometry();
            PathFigure pFigure7 = new PathFigure();
            pFigure7.StartPoint = new Point(0, 0);
            PolyBezierSegment pBezierSegment7 = new PolyBezierSegment();
            pBezierSegment7.Points.Add(new Point(710, 350));
            pBezierSegment7.Points.Add(new Point(710, 350));
            pBezierSegment7.Points.Add(new Point(710, 350));
            pFigure7.Segments.Add(pBezierSegment7);
            animationPath7.Figures.Add(pFigure7);

            //freeze path for performance benefits
            animationPath7.Freeze();

            //create the animation to move the card horizontally
            DoubleAnimationUsingPath translateXAnimation7 = new DoubleAnimationUsingPath();
            translateXAnimation7.PathGeometry = animationPath7;
            translateXAnimation7.PathGeometry = animationPath7;
            translateXAnimation7.Duration = TimeSpan.FromSeconds(.7);

            //set source property to x
            translateXAnimation7.Source = PathAnimationSource.X;

            Storyboard.SetTargetName(translateXAnimation7, "AnimatedTranslateTransform7");
            Storyboard.SetTargetProperty(translateXAnimation7, new PropertyPath(TranslateTransform.XProperty));

            DoubleAnimationUsingPath translateYAnimation7 = new DoubleAnimationUsingPath();
            translateYAnimation7.PathGeometry = animationPath7;
            translateYAnimation7.Duration = TimeSpan.FromSeconds(.7);

            translateYAnimation7.Source = PathAnimationSource.Y;

            Storyboard.SetTargetName(translateYAnimation7, "AnimatedTranslateTransform7");
            Storyboard.SetTargetProperty(translateYAnimation7, new PropertyPath(TranslateTransform.YProperty));

            //create a storyboard
            Storyboard.SetTargetName(translateYAnimation7, "AnimatedTranslateTransform7");
            Storyboard.SetTargetProperty(translateYAnimation7, new PropertyPath(TranslateTransform.YProperty));




            ////////////////////////////////////////////////
            //////// Deal card 4 ///////////////////////////
            ////////////////////////////////////////////////
            TranslateTransform moveCard6 = new TranslateTransform();
            this.RegisterName("AnimatedTranslateTransform6", moveCard6);
            card6.RenderTransform = moveCard6;

            //create the path
            PathGeometry animationPath6 = new PathGeometry();
            PathFigure pFigure6 = new PathFigure();
            pFigure6.StartPoint = new Point(0, 0);
            PolyBezierSegment pBezierSegment6 = new PolyBezierSegment();
            pBezierSegment6.Points.Add(new Point(810, 350));
            pBezierSegment6.Points.Add(new Point(810, 350));
            pBezierSegment6.Points.Add(new Point(810, 350));
            pFigure6.Segments.Add(pBezierSegment6);
            animationPath6.Figures.Add(pFigure6);

            //freeze path for performance benefits
            animationPath6.Freeze();

            //create the animation to move the card horizontally
            DoubleAnimationUsingPath translateXAnimation6 = new DoubleAnimationUsingPath();
            translateXAnimation6.PathGeometry = animationPath6;
            translateXAnimation6.PathGeometry = animationPath6;
            translateXAnimation6.Duration = TimeSpan.FromSeconds(.6);

            //set source property to x
            translateXAnimation6.Source = PathAnimationSource.X;

            Storyboard.SetTargetName(translateXAnimation6, "AnimatedTranslateTransform6");
            Storyboard.SetTargetProperty(translateXAnimation6, new PropertyPath(TranslateTransform.XProperty));

            DoubleAnimationUsingPath translateYAnimation6 = new DoubleAnimationUsingPath();
            translateYAnimation6.PathGeometry = animationPath6;
            translateYAnimation6.Duration = TimeSpan.FromSeconds(.6);

            translateYAnimation6.Source = PathAnimationSource.Y;

            Storyboard.SetTargetName(translateYAnimation6, "AnimatedTranslateTransform6");
            Storyboard.SetTargetProperty(translateYAnimation6, new PropertyPath(TranslateTransform.YProperty));

            //create a storyboard
            Storyboard.SetTargetName(translateYAnimation6, "AnimatedTranslateTransform6");
            Storyboard.SetTargetProperty(translateYAnimation6, new PropertyPath(TranslateTransform.YProperty));



            ////////////////////////////////////////////////
            //////// Deal card 5 ///////////////////////////
            ////////////////////////////////////////////////
            TranslateTransform moveCard5 = new TranslateTransform();
            this.RegisterName("AnimatedTranslateTransform5", moveCard5);
            card5.RenderTransform = moveCard5;

            //create the path
            PathGeometry animationPath5 = new PathGeometry();
            PathFigure pFigure5 = new PathFigure();
            pFigure5.StartPoint = new Point(0, 0);
            PolyBezierSegment pBezierSegment5 = new PolyBezierSegment();
            pBezierSegment5.Points.Add(new Point(240, -10));
            pBezierSegment5.Points.Add(new Point(240, -10));
            pBezierSegment5.Points.Add(new Point(240, -10));
            pFigure5.Segments.Add(pBezierSegment5);
            animationPath5.Figures.Add(pFigure5);

            //freeze path for performance benefits
            animationPath5.Freeze();

            //create the animation to move the card horizontally
            DoubleAnimationUsingPath translateXAnimation5 = new DoubleAnimationUsingPath();
            translateXAnimation5.PathGeometry = animationPath5;
            translateXAnimation5.PathGeometry = animationPath5;
            translateXAnimation5.Duration = TimeSpan.FromSeconds(.5);

            //set source property to x
            translateXAnimation5.Source = PathAnimationSource.X;

            Storyboard.SetTargetName(translateXAnimation5, "AnimatedTranslateTransform5");
            Storyboard.SetTargetProperty(translateXAnimation5, new PropertyPath(TranslateTransform.XProperty));

            DoubleAnimationUsingPath translateYAnimation5 = new DoubleAnimationUsingPath();
            translateYAnimation5.PathGeometry = animationPath5;
            translateYAnimation5.Duration = TimeSpan.FromSeconds(.5);

            translateYAnimation5.Source = PathAnimationSource.Y;

            Storyboard.SetTargetName(translateYAnimation5, "AnimatedTranslateTransform5");
            Storyboard.SetTargetProperty(translateYAnimation5, new PropertyPath(TranslateTransform.YProperty));

            //create a storyboard
            Storyboard.SetTargetName(translateYAnimation5, "AnimatedTranslateTransform5");
            Storyboard.SetTargetProperty(translateYAnimation5, new PropertyPath(TranslateTransform.YProperty));



            ////////////////////////////////////////////////
            //////// Deal card 6 ///////////////////////////
            ////////////////////////////////////////////////
            TranslateTransform moveCard4 = new TranslateTransform();
            this.RegisterName("AnimatedTranslateTransform4", moveCard4);
            card4.RenderTransform = moveCard4;

            //create the path
            PathGeometry animationPath4 = new PathGeometry();
            PathFigure pFigure4 = new PathFigure();
            pFigure4.StartPoint = new Point(0, 0);
            PolyBezierSegment pBezierSegment4 = new PolyBezierSegment();
            pBezierSegment4.Points.Add(new Point(340, -10));
            pBezierSegment4.Points.Add(new Point(340, -10));
            pBezierSegment4.Points.Add(new Point(340, -10));
            pFigure4.Segments.Add(pBezierSegment4);
            animationPath4.Figures.Add(pFigure4);

            //freeze path for performance benefits
            animationPath4.Freeze();

            //create the animation to move the card horizontally
            DoubleAnimationUsingPath translateXAnimation4 = new DoubleAnimationUsingPath();
            translateXAnimation4.PathGeometry = animationPath4;
            translateXAnimation4.PathGeometry = animationPath4;
            translateXAnimation4.Duration = TimeSpan.FromSeconds(.4);

            //set source property to x
            translateXAnimation4.Source = PathAnimationSource.X;

            Storyboard.SetTargetName(translateXAnimation4, "AnimatedTranslateTransform4");
            Storyboard.SetTargetProperty(translateXAnimation4, new PropertyPath(TranslateTransform.XProperty));

            DoubleAnimationUsingPath translateYAnimation4 = new DoubleAnimationUsingPath();
            translateYAnimation4.PathGeometry = animationPath4;
            translateYAnimation4.Duration = TimeSpan.FromSeconds(.4);

            translateYAnimation4.Source = PathAnimationSource.Y;

            Storyboard.SetTargetName(translateYAnimation4, "AnimatedTranslateTransform4");
            Storyboard.SetTargetProperty(translateYAnimation4, new PropertyPath(TranslateTransform.YProperty));

            //create a storyboard
            Storyboard.SetTargetName(translateYAnimation4, "AnimatedTranslateTransform4");
            Storyboard.SetTargetProperty(translateYAnimation4, new PropertyPath(TranslateTransform.YProperty));



            ////////////////////////////////////////////////
            //////// Deal card 7 ///////////////////////////
            ////////////////////////////////////////////////
            TranslateTransform moveCard3 = new TranslateTransform();
            this.RegisterName("AnimatedTranslateTransform3", moveCard3);
            card3.RenderTransform = moveCard3;

            //create the path
            PathGeometry animationPath3 = new PathGeometry();
            PathFigure pFigure3 = new PathFigure();
            pFigure3.StartPoint = new Point(0, 0);
            PolyBezierSegment pBezierSegment3 = new PolyBezierSegment();
            pBezierSegment3.Points.Add(new Point(440, -10));
            pBezierSegment3.Points.Add(new Point(440, -10));
            pBezierSegment3.Points.Add(new Point(440, -10));
            pFigure3.Segments.Add(pBezierSegment3);
            animationPath3.Figures.Add(pFigure3);

            //freeze path for performance benefits
            animationPath3.Freeze();

            //create the animation to move the card horizontally
            DoubleAnimationUsingPath translateXAnimation3 = new DoubleAnimationUsingPath();
            translateXAnimation3.PathGeometry = animationPath3;
            translateXAnimation3.PathGeometry = animationPath3;
            translateXAnimation3.Duration = TimeSpan.FromSeconds(.3);

            //set source property to x
            translateXAnimation3.Source = PathAnimationSource.X;

            Storyboard.SetTargetName(translateXAnimation3, "AnimatedTranslateTransform3");
            Storyboard.SetTargetProperty(translateXAnimation3, new PropertyPath(TranslateTransform.XProperty));

            DoubleAnimationUsingPath translateYAnimation3 = new DoubleAnimationUsingPath();
            translateYAnimation3.PathGeometry = animationPath3;
            translateYAnimation3.Duration = TimeSpan.FromSeconds(.3);

            translateYAnimation3.Source = PathAnimationSource.Y;

            Storyboard.SetTargetName(translateYAnimation3, "AnimatedTranslateTransform3");
            Storyboard.SetTargetProperty(translateYAnimation3, new PropertyPath(TranslateTransform.YProperty));

            //create a storyboard
            Storyboard.SetTargetName(translateYAnimation3, "AnimatedTranslateTransform3");
            Storyboard.SetTargetProperty(translateYAnimation3, new PropertyPath(TranslateTransform.YProperty));




            ////////////////////////////////////////////////
            //////// Deal card 8 ///////////////////////////
            ////////////////////////////////////////////////
            TranslateTransform moveCard2 = new TranslateTransform();
            this.RegisterName("AnimatedTranslateTransform2", moveCard2);
            card2.RenderTransform = moveCard2;

            //create the path
            PathGeometry animationPath2 = new PathGeometry();
            PathFigure pFigure2 = new PathFigure();
            pFigure2.StartPoint = new Point(0, 0);
            PolyBezierSegment pBezierSegment2 = new PolyBezierSegment();
            pBezierSegment2.Points.Add(new Point(540, -10));
            pBezierSegment2.Points.Add(new Point(540, -10));
            pBezierSegment2.Points.Add(new Point(540, -10));
            pFigure2.Segments.Add(pBezierSegment2);
            animationPath2.Figures.Add(pFigure2);

            //freeze path for performance benefits
            animationPath2.Freeze();

            //create the animation to move the card horizontally
            DoubleAnimationUsingPath translateXAnimation2 = new DoubleAnimationUsingPath();
            translateXAnimation2.PathGeometry = animationPath2;
            translateXAnimation2.PathGeometry = animationPath2;
            translateXAnimation2.Duration = TimeSpan.FromSeconds(.2);

            //set source property to x
            translateXAnimation2.Source = PathAnimationSource.X;

            Storyboard.SetTargetName(translateXAnimation2, "AnimatedTranslateTransform2");
            Storyboard.SetTargetProperty(translateXAnimation2, new PropertyPath(TranslateTransform.XProperty));

            DoubleAnimationUsingPath translateYAnimation2 = new DoubleAnimationUsingPath();
            translateYAnimation2.PathGeometry = animationPath2;
            translateYAnimation2.Duration = TimeSpan.FromSeconds(.2);

            translateYAnimation2.Source = PathAnimationSource.Y;

            Storyboard.SetTargetName(translateYAnimation2, "AnimatedTranslateTransform2");
            Storyboard.SetTargetProperty(translateYAnimation2, new PropertyPath(TranslateTransform.YProperty));

            //create a storyboard
            Storyboard.SetTargetName(translateYAnimation2, "AnimatedTranslateTransform2");
            Storyboard.SetTargetProperty(translateYAnimation2, new PropertyPath(TranslateTransform.YProperty));



            ////////////////////////////////////////////////
            //////// Deal card 9 ///////////////////////////
            ////////////////////////////////////////////////
            TranslateTransform moveCard1 = new TranslateTransform();
            this.RegisterName("AnimatedTranslateTransform1", moveCard1);
            card1.RenderTransform = moveCard1;

            //create the path
            PathGeometry animationPath1 = new PathGeometry();
            PathFigure pFigure1 = new PathFigure();
            pFigure1.StartPoint = new Point(0, 0);
            PolyBezierSegment pBezierSegment1 = new PolyBezierSegment();
            pBezierSegment1.Points.Add(new Point(640, -10));
            pBezierSegment1.Points.Add(new Point(640, -10));
            pBezierSegment1.Points.Add(new Point(640, -10));
            pFigure1.Segments.Add(pBezierSegment1);
            animationPath1.Figures.Add(pFigure1);

            //freeze path for performance benefits
            animationPath1.Freeze();

            //create the animation to move the card horizontally
            DoubleAnimationUsingPath translateXAnimation1 = new DoubleAnimationUsingPath();
            translateXAnimation1.PathGeometry = animationPath1;
            translateXAnimation1.PathGeometry = animationPath1;
            translateXAnimation1.Duration = TimeSpan.FromSeconds(.1);

            //set source property to x
            translateXAnimation1.Source = PathAnimationSource.X;

            Storyboard.SetTargetName(translateXAnimation1, "AnimatedTranslateTransform1");
            Storyboard.SetTargetProperty(translateXAnimation1, new PropertyPath(TranslateTransform.XProperty));

            DoubleAnimationUsingPath translateYAnimation1 = new DoubleAnimationUsingPath();
            translateYAnimation1.PathGeometry = animationPath1;
            translateYAnimation1.Duration = TimeSpan.FromSeconds(.1);

            translateYAnimation1.Source = PathAnimationSource.Y;

            Storyboard.SetTargetName(translateYAnimation1, "AnimatedTranslateTransform1");
            Storyboard.SetTargetProperty(translateYAnimation1, new PropertyPath(TranslateTransform.YProperty));

            //create a storyboard
            Storyboard.SetTargetName(translateYAnimation1, "AnimatedTranslateTransform1");
            Storyboard.SetTargetProperty(translateYAnimation1, new PropertyPath(TranslateTransform.YProperty));





            ////////////////////////////////////////////////
            //////// Deal the cards ///////////////////////////
            ////////////////////////////////////////////////
            Storyboard pathAnimationStoryboard = new Storyboard();
            pathAnimationStoryboard.Children.Add(translateXAnimation9);
            pathAnimationStoryboard.Children.Add(translateYAnimation9);

            pathAnimationStoryboard.Children.Add(translateXAnimation8);
            pathAnimationStoryboard.Children.Add(translateYAnimation8);

            pathAnimationStoryboard.Children.Add(translateXAnimation7);
            pathAnimationStoryboard.Children.Add(translateYAnimation7);

            pathAnimationStoryboard.Children.Add(translateXAnimation6);
            pathAnimationStoryboard.Children.Add(translateYAnimation6);

            pathAnimationStoryboard.Children.Add(translateXAnimation5);
            pathAnimationStoryboard.Children.Add(translateYAnimation5);

            pathAnimationStoryboard.Children.Add(translateXAnimation4);
            pathAnimationStoryboard.Children.Add(translateYAnimation4);

            pathAnimationStoryboard.Children.Add(translateXAnimation3);
            pathAnimationStoryboard.Children.Add(translateYAnimation3);

            pathAnimationStoryboard.Children.Add(translateXAnimation2);
            pathAnimationStoryboard.Children.Add(translateYAnimation2);

            pathAnimationStoryboard.Children.Add(translateXAnimation1);
            pathAnimationStoryboard.Children.Add(translateYAnimation1);

            pathAnimationStoryboard.Begin(this);


            //change the image source of the card. will be used to display actual cards dealt to players/dealer
            string sUri = @"Images\clubs-2-150.png";
            Uri src = new Uri(sUri, UriKind.RelativeOrAbsolute);
            BitmapImage bmp = new BitmapImage(src);
            card9.Source = bmp;
            card8.Source = bmp;
            card7.Source = bmp;
            card6.Source = bmp;
            card5.Source = bmp;
            card4.Source = bmp;
            card3.Source = bmp;

        }
	}
}
