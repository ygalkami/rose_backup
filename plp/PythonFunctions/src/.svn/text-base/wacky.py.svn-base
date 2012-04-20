# Profs say the darnedest things...
# by David Pick, 9/8/09

# Well done. --CCC

import datetime

quotes = []

def add_quote(name, quote, date):
    quotes.append([name, quote, date])
    quotes.sort(date_cmp)
    
def print_quotes(name):
    for i, v in enumerate(quotes):
        if v[0] == name:
            print v
            
def date_cmp(date1, date2):
    if date1[2] > date2[2]:
        return 1
    elif date1[2] == date2[2]:
        return 0
    else:
        return -1
    
    
add_quote("Sriram", "I don't know", datetime.date(2009, 4, 5))
add_quote("Sriram", "This is 2", datetime.date(2002, 3, 4))
add_quote("Curt", "Quote", datetime.date(2004, 2, 7))
add_quote("Curt", "Quote", datetime.date(2007, 4, 8))
add_quote("Curt", "Quote", datetime.date(2002, 4, 5))
add_quote("Sriram", "quote", datetime.date(2005, 4, 1))

print_quotes("Curt")
