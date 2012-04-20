# BlackJack simulation.
# Originally written by Claude Anderson for CSSE 120.  September 23, 2007.
# Refactored to use objects by Curt Clifton.  Sept. 29, 2007.

from random import randrange
from time import sleep
from win_in import *

# Define some constants used by many functions
suits = ['Clubs', 'Diamonds', 'Hearts', 'Spades']
cardNames = ['Ace', 'Deuce', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack','Queen', 'King']
winningScore = 21
dealerMustHoldScore = 16
DRAMATIC_PAUSE_DURATION = 3

class Card:
    """This class represents a card from a standard deck."""
    def __init__(self, card, suit):
        self.cardName = card
        self.suitName = suit
    
    def getValue(self):
        """Returns the value of this card in BlackJack.  
        Aces always count as one, so hands need to adjust 
        to count aces as 11."""
        pos = cardNames.index(self.cardName)
        if pos < 10:
            return pos + 1
        return 10

    def __str__(self):
        return self.cardName + " of " + self.suitName
        
class CardCollection:
    """This class represents a collection of cards, either a single hand or
    the whole deck."""
    def __init__(self, newDeck = False):
        """Creates a new collection of cards.  By default it's empty, but
        if newDeck is True then the collection is a full standard deck."""
        self.name = None
        self.cardList = []
        self.hideFirst = True
        if newDeck:
            # Create an entire deck of cards
            for s in suits:
                for c in cardNames:
                    self.insert(Card(c, s))

    def insert(self, card):
        """Adds the given card to this collection."""
        self.cardList.append(card)

    def getValue(self):
        """Returns the best score for this collection 
        in the game of BlackJack."""
        score = 0
        hasAce = False
        for card in self.cardList:
            val = card.getValue()
            score += val
            if val == 1:
                hasAce = True
        if score <= winningScore - 10 and hasAce:
            score += 10
        return score

    def dealTo(self, hand):
        """Deals one card from this collection to the given hand."""
        hand.insert(self._dealCard())
    
    def showFirstCard(self):
        """Turns up the first card in the deck."""
        self.hideFirst = False
        
    def initialDeal(self, numHands, numCards):
        """Returns a list of numHands hands, each containing numCards cards,
        dealing one card at a time to each hand."""
        # Creates initial empty hands
        resultHands = []
        for i in range(numHands):
            resultHands.append(CardCollection())
        # Deals numCards rounds, giving one card to each hand
        for round in range(numCards):
            for h in range(numHands):
                self.dealTo(resultHands[h])
        return resultHands
        
    def setName(self, person):
        """Records that this hand is owned by the given person."""
        self.name = person
        
    def _dealCard(self):
        """Returns a random card from this deck."""
        pos = randrange(len(self.cardList))
        card = self.cardList[pos]
        self.cardList.remove(card)
        return card

    def __str__(self):
        if self.name == None:
            result = 'Deck:'
        else:
            result = self.name + "'s hand:"
        if self.hideFirst:
            result += '\n   Face Down\n'
        else:
            result += "(score is %d)\n" % (self.getValue())
            result += '   ' + str(self.cardList[0]) + '\n'
        for i in range(1, len(self.cardList)):
            result += '   ' + str(self.cardList[i]) + '\n'
        return result


# Show the contents of both player's hands.
def displayGameState(playerHand, dealerHand):
    print dealerHand
    print playerHand
 
# Determine whether the dealer "takes a hit" (gets another card).   
def dealerHit(dealerHand):
    dealerScore = dealerHand.getValue()
    return dealerScore < dealerMustHoldScore

# Ask player whether she wants another card.
def playerHit(playerScore):
    if playerScore > winningScore:
        return False
    answer = win_raw_input("Hit? (Y/N) ")
    firstChar = answer[0].upper()
    return firstChar == 'Y'

# Player takes hits until Busted or stops requesting hits.
def playerPlays(player, dealer, deck):
    while playerHit(player.getValue()):
        deck.dealTo(player)
        displayGameState(player, dealer)

# Dealer takes hits until no more hits allowed.
def dealerPlays(player, dealer, deck):
    displayGameState(player, dealer)
    while dealerHit(dealer):
        sleep(DRAMATIC_PAUSE_DURATION)
        print "Dealer takes a hit"
        deck.dealTo(dealer)
        displayGameState(player, dealer)
        
# Figure out who won.
def finalTally(player, dealer):
    playerScore = player.getValue()
    dealerScore = dealer.getValue()
    if dealerScore > winningScore:
        print "DEALER IS BUSTED, YOU WIN"
    elif dealerScore > playerScore:
        print "DEALER WINS"
    else:
        print "YOU WIN!"
  
def main():
    deck = CardCollection(True)
    player, dealer = deck.initialDeal(2,2)
    player.setName('Player')
    dealer.setName('Dealer')
    player.showFirstCard()
    displayGameState(player, dealer)
    playerPlays(player, dealer, deck)
    if player.getValue() > winningScore:
        print "BUSTED!  You lose."
        dealer.showFirstCard()
    else:
        print "Now Dealer will play ..."
        dealer.showFirstCard()
        dealerPlays(player, dealer, deck)
        finalTally(player, dealer) 
    displayGameState(player, dealer)

#main()
card = Card('7','Clubs')
print card.getValue()
print card
