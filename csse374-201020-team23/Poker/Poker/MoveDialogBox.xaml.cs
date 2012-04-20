namespace Poker
{
    using System;
    using System.Collections;
	using System.Collections.Generic;
    using System.Collections.ObjectModel;
    using System.Reflection;
    using System.Windows;
    using System.Windows.Controls;
    using System.Windows.Controls.Primitives;
    using System.Windows.Data;
    using System.Windows.Media;
	
	
	public partial class MoveDialogBox : Window
    {
		public Move moveChoice;
		private bool moveChosen;
		
        public MoveDialogBox(List<Move> legalMoves)
        {
            InitializeComponent();
			this.moveChosen = false;
			this.moveChoiceComboBox.Items.Clear();

			foreach (Move moveOpt in legalMoves)
			{
				this.moveChoiceComboBox.Items.Add(moveOpt);
			}
			this.moveChoiceComboBox.SelectedIndex = 0;
        }

        private void submitButton_Click(object sender, RoutedEventArgs e)
        {
			this.moveChoice = (Move) moveChoiceComboBox.SelectedItem;
			this.moveChosen = true;
            this.DialogResult = true;
        }

		private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
		{
			if (moveChosen == false)
			{
				e.Cancel = true;
				MessageBox.Show("You must choose a move.");
			}
		}

    }
}