require 'pp'

counter = 1
file = File.new("ospd.txt", "r")
$words = {}
$seen = []
$chain = []
while (line = file.gets)
	line = line.chomp
	if $words[line.length] == nil
		$words[line.length] = [line]
	else
		$words[line.length] << line
	end
end
file.close

#If the words are the same length, return the number of letters that are different
def compare_words(first_word, second_word)
	if first_word.length != second_word.length
		return -1
	end

	count = 0
		
	(0..first_word.length - 1).each do |i|
	if first_word[i] != second_word[i]
		count = count + 1
	end
	end

	return count
end

#return all words that are the same length as the input word
def words_of_same_length(word)
	return $words[word.length]
end

#return all words that are the same length, and 1 letter different than the input word
def words_1_letter_diff(word)
	return words_of_same_length(word).find_all {|w| compare_words(word, 	w) == 1}
end

#use an exhaustive search to find a path from the first word to the second
def find_solution(first_word, second_word)
	if first_word.length != second_word.length
		return "bad input, words must be the same length"
	end

	current_word = first_word
	$chain << first_word

	while true
		possible = words_1_letter_diff(current_word)
		possible = possible - $seen
		if possible.include?(second_word)
			return $chain << second_word
		end

		if possible != []
			$chain << possible.last
			$seen << possible.last
			current_word = $chain.last
		else
			backtrack()
			current_word = $chain.last
		end

		if $chain == []
			return "impossible"
		end

		if $chain.last == second_word
			return $chain
		end
	end
end

def backtrack()
	$chain.slice!(-1)
end

pp find_solution(ARGV[0], ARGV[1]) 
