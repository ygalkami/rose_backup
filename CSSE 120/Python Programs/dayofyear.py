# Calculates days of year for a given date
months = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug" "sep", "oct", "nov", "dec"]

length = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

m = raw_input("Enter month name (3-letters, lowercase): ")
d = input("Enter the day of the month: ")

# Find out where in list of months this month is
indx = months.index(m)

dayOfYr = 0

for i in range (indx):
    dayOfYr = dayOfYr + length[i]

dayOfYr = dayOfYr + d

print "The day of the year is ", dayOfYr
