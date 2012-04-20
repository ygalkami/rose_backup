#This program finds the average of malformed numbers stored in a text file.
#Written by David Pick    

from graphics import *
from string import *
from win_in import *

# Get the input file name from user by getting the text of the "Entry object"
# after the user clicks in the window with the mouse.
# The button is simply a text field that gives feedback to the user
# This function should return the input file opend for reading
def getInputFile(window, entry, button):
    # get file from user
    # Use a while loop and exception handling to check that
    # the file exists.
    # If file does not exist (IOError should be caught),
    # Display appropriate message on button and give user another opportunity
    # to enter the name of a file that exists.
    # When the user enters the name of a file that exists,
    # Give appropriate feedback and break
    # out of the while loop
    # REPLACE WITH YOUR CODE
    button = Rectangle(Point(50, 150), Point(150, 200))
    button.draw(window)
    text = Text(Point(100,160), "Average Files")
    text.draw(window)
    entry = Entry(Point(100, 100),20)
    entry.setText("Enter a file name")
    entry.draw(window)
    window.getMouse()
    fileName = entry.getText()
    while True:
        try:
            myfile = open(fileName, 'r')
            return entry.getText()
            break
        except IOError:
            return entry.setText("Could not find file " + entry.getText() + " Please try again")
            break


# Find the sum and count of the numbers in the given line.
# Returns a pair of #s consisting of the given line's sum + old_sum
# and the given line's count of # of numbers found + old_count.
#def updateSumAndCount(line, old_sum, old_count):
def updateSumAndCount(filename):
    try:
        sum = 0.0
        count = 0
        print filename
        openfile = open(filename, 'r')
        for line in filename:
            line = openfile.readline()
            while line !="":
                for xStr in line.split():
                    sum = sum + eval(xStr)
                    count = count + 1
                line = openfile.readline()
            return sum, count
        
    except SyntaxError:
        line = line.strip()
        for i in range(33,47):
            line = line.strip(chr(i))
        for i  in range(58,150):
            line = line.strip(chr(i))
        
        for xStr in line.split():
            sum = sum + eval(xStr)
            count = count + 1
        sum = sum + float(line)
        return sum, count
    except IOError:
        return
# Reads numbers from the given file, which must already be open
# for reading,
# and returns the mean and count of all the numbers found.
def computeMeanAndCount(sum, count):
    print sum / count
    


# create the Graphical User Interface and run the program.
def main():
    # Fill in your code to create the GUI
    # This function should also run the program
    
    # Can use a mouse click event to terminate the program
    # Don't forget to close the window you created
    # replace with your code`    
    win = GraphWin("File Average", 300, 300)
    #button = Rectangle(Point(50, 150), Point(150, 200))
    #button.draw(win)
    file = getInputFile(win, "test.txt", "button")
    total, count2 = updateSumAndCount(file)
    computeMeanAndCount(total, count2)
    win.getMouse()
    win.close()
main()