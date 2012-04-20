import string

def main():
    inString = raw_input("Please enter the AscII-encoded message: ")

    message = ""
    for numStr in string.split(inString):
        asciiNum = eval(numStr)
        message = message + chr(asciiNum)

    print message

main()
