# Profs. say the darndest things.  And we won't forget it.
# by Curt Clifton, March 10, 2008.

from __future__ import with_statement
import pickle

data = {}
data_file = "wacky_data.txt"

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

def wacky():
    global data
    try:
        with open(data_file, 'rb') as f:
            data = pickle.load(f)
    except IOError:
        data = {}
            
    main_prompt = "Enter 'a' to add a quote, 'p' to print quotes, and 'q' to quit: "
    answer = raw_input(main_prompt).strip()
    while not answer.startswith('q'):
        if answer.startswith('a'):
            name = raw_input("Who spaketh the wackiness? ").strip()
            date = raw_input("When did they speak thusly? ").strip()
            quote = raw_input("What sayeth they? ").strip()
            add_quote(name, quote, date)
        elif answer.startswith('p'):
            name = raw_input("Whom do you seek? ").strip()
            print_quotes(name)
        else:
            print "I don't understand, '%s'" % (answer)
        answer = raw_input(main_prompt).strip()
    print "Thanks for playing."
    with open(data_file, 'wb') as f:
        pickle.dump(data, f)

if __name__ == '__main__':
    wacky()