

def main():
    import math
    x1 = input("Enter the x value of the first point: ")
    y1 = input("Enter the y value of the first point: ")
    x2 = input("Enter the x value of the second point: ")
    y2 = input("Enter the y value of the second point: ")

    distance = math.sqrt((x2-x1)^2+(y2-y1)^2)

    print "The distance between the points is", distance

main()
