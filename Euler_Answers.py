def print_nat_nums(n):
	sum = 0
	for i in range(0, n):
		if i % 3 == 0 or i % 5 == 0:
			sum += i
	return sum

def fib(start_fib, n):
	if n == 0:
		return start_fib[0]
	elif n == 1:
		return start_fib[1]
	else:
		temp = start_fib[0]
		start_fib[0] = start_fib[1]
		start_fib[1] = temp + start_fib[1]
		print start_fib
		return fib(start_fib, n - 1)

#fib seq up until n or value greater than 4,000,000
def all_fib_under(n):
	values = [0, 1]
	for i in range(n):
		values.append(values[len(values) - 1] + values[len(values) - 2])
		if values[len(values) - 1] > 4000000:
			return values
	return values

#print all even-valued terms in the fibonacci seq under 4 million
def even_fib():
	vals = all_fib_under(4000000)
	sum = 0
	for i in vals:
		if i % 2 == 0:
			sum += i
	return sum

#find largest prime factor of 600851475143
def prime_factors(n):
	newnum = n
	newtext = [] 
	checker = 2

	while(checker * checker <= newnum):
		if (newnum % checker == 0):
			newtext.append(checker)
			newnum = newnum / checker
		else:
			checker = checker + 1
	
	if (newnum != 1):
		newtext.append(newnum)
	if (newtext == [] + [n]):
		newtext = "Prime: " + newtext
	
	return newtext
			

#print prime_factors(600851475143)

#find the largest palindrome made from the rpoduct of two 3-digit numbers
def largest_palindrome():
	largest = 0
	for i in range(100, 999):
		for j in range(100, 999):
			temp = i * j
			string = str(temp)
			if (string == string[::-1]) and temp > largest:
				largest = temp 
	return largest 

#print largest_palindrome()

#smallest number evenly divisible by all the numbers from 1 to 20
def divisible_by_1_to_20():
	result = 2520
	while(check(result) == False):
		result += 2520
	
	return result

def check(n):
	for i in range(11, 20):
		if (n % i != 0):
			return False
	return True

#print divisible_by_1_to_20()

#find the difference between the sum of the squares of the first 100 natural nums and the square of the sum
#sum = 0
#sum_squares = 0
#for i in range(0, 101):
#	sum_squares += i * i
#	sum += i

#print (sum * sum) - sum_squares 

#find the 10,001st prime
def primes(n):
	vals = range(0, n)
	for i in range(2, n):
		if vals[i] != 0 and i * i < n:
			for j in range(i * i, n, i):
				vals[j] = 0

	return vals

#count = 0
#for i in primes(30):
#	if i != 0:
#		print str(count) + " = " + str(i)
#		count = count + 1	

#print primes(10000)

#def find the one pythagorean triplet for which a + b + c = 1000

def pythag_tiplit():
	for a in range(1, 1000):
		for b in range(1, 1000):
			for c in range(1, 1000):
			#	print str(a) + " " + str(b) + " " + str(c)
				if a + b + c == 1000 and a * a + b * b == c * c:
					print str(a) + " " + str(b) + " " + str(c)


#calculate the sum of all the primes below 2 million
#sum = 0
#for i in filter (lambda a: a != 0, primes(2000000)):
#	if i != 0:
#		sum += i
#print filter (lambda a: a != 0, primes(2000000))
#print sum




#print print_nat_nums(1000)
#start_fib = [0, 1]
#print fib(start_fib, 4)
#print all_fib_under(100)
#print even_fib()
