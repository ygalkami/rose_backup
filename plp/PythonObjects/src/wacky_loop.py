# Profs. say the darndest things.  And we won't forget it.
# by David Pick, 9/12/09
# Points: 5 / 5
import datetime
import pickle
import os

quotes = []

class Quote:
    name = ""
    quote = ""
    date = ""
    
    def get_date(self):
        return self.date
    
    def get_name(self):
        return self.name
    
    def get_quote(self):
        return self.quote
    
    def __init__(self, name, quote, date_said):
        self.name = name
        self.quote = quote
        self.date = date_said

def add_quote(name, quote, date):
    quotes.append(Quote(name, quote, date))
    quotes.sort(date_cmp)
    
def print_quotes(name):
    for i, v in enumerate(quotes):
        if v.get_name() == name:
            print v.get_name() + " said '" + v.get_quote() + "' on " + v.get_date().__str__()
            
def date_cmp(date1, date2):
    date1 = date1.get_date()
    date2 = date2.get_date()
    if date1 > date2:
        return 1
    elif date1 == date2:
        return 0
    else:
        return -1
    
filename = "quotes.txt"
try:
    FILE = open(filename, "rb")
    quotes = pickle.load(FILE)
except IOError:
    FILE = open(filename, "wb")
except EOFError:
    FILE = open(filename, "wb")

#if FILE.read() != '':
#    quotes = pickle.load(FILE)
#    print quotes

var = raw_input("Enter 'a' to add a quote, 'p' to print quotes, and 'q' to exit: ")    
while var != 'q':
    if var == 'a':
        name = raw_input("Who said the quote: ")
        quote = raw_input("What did they say: ")
        year = raw_input("What year did they say it: ")
        month = raw_input("What month(1 - 12) did they say it: ")
        day = raw_input("What day did they say it(1 - 31): ")
        add_quote(name, quote, datetime.date(int(year), int(month), int(day)))
    elif var == 'p':
        name = raw_input("Whose quotes would you like to see? ")
        print_quotes(name)
    var = raw_input("Enter 'a' to add a quote, 'p' to print quotes, and 'q' to exit: ")

FILE.close()
FILE = open(filename, "wb")

if quotes != []:
    pickle.dump(quotes, FILE)
    
print "Thanks for playing"