# BlackJack simulation.
# Written by Claude ANderson for CSSE 120.  September 23, 2007.

from random import  randrange
from time import sleep
from win_in import *

# Define some constants used by many functions
suits = ['Clubs', 'Diamonds', 'Hearts', 'Spades']
cardNames = ['Ace', 'Deuce', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack','Queen', 'King']
winningScore = 21
dealerMustHoldScore = 16

# A card is represented by a list [cardName, suit],
# for example ['Ace','Clubs'] or ['7','Diamonds']
# A hand or a deck is a list of cards.

# return a string that represents the given card.
def cardString(card):
    return '   ' + card[0] + " of " + card[1]

# Create an entire deck of cards
def newDeck():
    deckList = []
    for s in suits:
        for c in cardNames:
            deckList.append([c, s])
    return deckList

# calculate how many points this card is worth.  Face cards count 10.
# Ace Counts 1 (or 11, but that adjustment is made at the handScore level).
def cardValue(card):
    name = card[0]
    pos = cardNames.index(name)
    if pos < 10:
        return pos + 1
    return 10

# Calculate the score for the whole hand.
def handScore(hand):
    score = 0
    hasAce = False
    for card in hand:
        val = cardValue(card)
        score += val
        if val == 1:
            hasAce = True
    if score <= winningScore - 10 and hasAce:
        score = score + 10
    return score

# Remove  a random card from the deck and return it
def dealCard(deck):
    pos = randrange(len(deck))
    card = deck[pos]
    deck.remove(card)
    return card

# deal a card from this deck and place it in this hand.
def dealTo(hand, deck):
    hand.append(dealCard(deck))
    
# print out the contents of this hand.
# If the hand is the dealer's and the player hasn't played yet, 
#    showAll will be False.
def displayHand(name, hand, showAll):
    print name + "'s hand:",
    if showAll:
        print "(score is %d)" % (handScore(hand))
        print cardString(hand[0])
    else:
        print 
        print '   Face Down'
    # print the rest of the hand.
    for i in range(1, len(hand)):
        print cardString(hand[i])

# Show the contents of both player's hands.
def displayGameState(playerHand, dealerHand, gameOver):
    displayHand('Dealer', dealerHand, gameOver)
    displayHand('Player', playerHand, True)
 
# Determine whether the dealer "takes a hit" (gets another card).   
def dealerHit(dealerHand):
    dealerScore = handScore(dealerHand)
    return dealerScore < dealerMustHoldScore

# Ask player whether she wants another card.
def playerHit(playerScore):
    if playerScore > winningScore:
        return False
    answer = win_raw_input("Hit? (Y/N) ")
    firstChar = answer[0]
    return firstChar == 'y' or firstChar == 'Y'

# Deal two cards to each player.
def initialDeal(deck):
    playerHand = []
    dealerHand = []
    for i in [0, 1]:
      dealTo(playerHand, deck)
      dealTo(dealerHand, deck)
    return playerHand, dealerHand

# Player takes hits until Busted or stops requesting hits.
def playerPlays(player, dealer, deck):
    while playerHit(handScore(player)):
        dealTo(player, deck)
        displayGameState(player, dealer, False)

# Dealer takes hits until no more hits allowed.
def dealerPlays(player, dealer, deck):
    displayGameState(player, dealer, True)
    while dealerHit(dealer):
        sleep(3)
        print "Dealer takes a hit"
        dealTo(dealer, deck)
        displayGameState (player, dealer, True)
        
# Figure out who won.
def finalTally(player, dealer):
    playerScore = handScore(player)
    dealerScore = handScore(dealer)
    if dealerScore > winningScore:
        print "DEALER IS BUSTED, YOU WIN"
    elif dealerScore > playerScore:
        print "DEALER WINS"
    else:
        print "YOU WIN!"
    
def playonegame():
    deck = newDeck()
    player, dealer = initialDeal(deck)
    displayGameState(player, dealer, False)
    playerPlays(player, dealer, deck)
    if handScore(player) > winningScore:
        print "BUSTED!  You lose."
    else:
        print "Now Dealer will play ..."
        dealerPlays(player, dealer, deck)
        finalTally(player, dealer) 
    displayGameState(player, dealer, True)
    return player, dealer

wins = 0
losses = 0
numgames = input("How many games would you like to play?")
numgames = int(numgames)
#play for a user defined number of games and report and plays wins and losses
for i in range(numgames):
    player, dealer = playonegame()
    playerscore = handScore(player)
    dealerscore = handScore(dealer)
    if dealerscore > winningScore:
        wins = wins + 1
    elif dealerscore > playerscore:
        losses = losses + 1
    else:
        wins = wins + 1
    print "You are " + str(wins) + " - " + str(losses)
    print "There are " + str((numgames) - (wins + losses)) + " games remaining"
