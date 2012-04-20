def slices():
    word = raw_input("Enter a word: ")
    for i in range(int(len(word))):
        slice = word[0:i + 1]
        print slice

slices()