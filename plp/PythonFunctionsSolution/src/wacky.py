# Profs say the darnedest things...
# by Curt Clifton, March 6, 2008

from datetime import date

data = {}

def add_quote(name, quote, date):
    if not data.has_key(name):
        data[name] = {}
    quotes_by_name = data[name]
    if not quotes_by_name.has_key(date):
        quotes_by_name[date] = set([])
    quotes_on_day = quotes_by_name[date]
    quotes_on_day.add(quote)

def print_quotes(name):
    if data.has_key(name):
        print name + "'s record of wackiness:"
        # FIXME: better to display these in chronological order
        for date, quotes in data[name].iteritems():
            print "    On %s:" % (date)
            for q in quotes:
                print "        ", q
    else:
        print name, "speaketh not wackily."

if __name__ == '__main__':
    add_quote('Curt', 'That rabbits got a mean streak a mile wide', date(2008, 3, 6))
    add_quote('Curt', 'Ni!', date(2008, 3, 6))
    add_quote('Curt', "I'm not dead yet!", date(2007, 12, 31))
    add_quote('Matt', 'Message for you, sir', date(1914, 6, 5))
    print_quotes('Curt')
    print_quotes('Matt')
    print_quotes('Steve')