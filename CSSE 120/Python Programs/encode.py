# Sample program to convert text to a "secret code".
# Based on Zelle, ch. 4.4.

def main():
    # Gets the message and key from the user
    message = raw_input("Please enter the message to encode: ")
    key = input("Please enter an integer key between -30 and 100: ")

    # Iterates over the message, generating a code for each character
    codeList = []
    for c in message:
        code = ord(c) + key
        codeList.append(code)
        
    print codeList

main()
