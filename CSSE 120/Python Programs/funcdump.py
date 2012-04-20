#   This program will write values from a function to a specified file

from math import *

def main():
    # Get the file name from the user
    filename = raw_input("Enter a filename: ")
    # Create the file and open it for writing
    filename = open(filename, 'w')
    # Write the x and y values to the file
    for i in range(720):
        value = float(200 + 200*cos((i*pi)/180))
        filename.write("%3d      %0.3f\n" % (i, value))
main()
