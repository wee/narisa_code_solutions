class WordGuess
  def initialize(word)
    @word = word
  end
  
  def try(input)
    result = []
    masked_word = '*' * @word.length
    to_array(input).each do |alphabet|
      masked_word = check_alphabet(masked_word, alphabet)
      result << alphabet + ' ' + masked_word
      break if correct?(masked_word)
    end
    result << (correct?(masked_word) ? 'You win!' : 'You lose!')
  end
  
  def check_alphabet(masked_word, alphabet)
    @word.split('').each_with_index do |char, index|
      masked_word[index] = char if char == alphabet
    end
    masked_word
  end
  
  def correct?(word)
    @word == word
  end
  
  def to_array(input)
    input.is_a?(String) ? input.split('') : input
  end 
end