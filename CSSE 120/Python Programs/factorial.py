def main():
    import math
    n = input("Enter a number: ")
    factorial = 1
    for i in range(1, n + 1):
        factorial = i * factorial
        
    print factorial

main()
