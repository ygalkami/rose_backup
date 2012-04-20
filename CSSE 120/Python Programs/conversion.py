#this program will convert degrees C to degrees F
#Written by David Pick

def convert():
    for i in range(11):
     #convert values from C to F
     ferenheight = (9/5) * (i * 10) + 32
     #display values
     print (i * 10),"C =", ferenheight,"F"

convert()
