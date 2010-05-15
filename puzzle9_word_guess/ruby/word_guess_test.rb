require File.dirname(__FILE__) + '/word_guess'

class WordGuessTest <  Test::Unit::TestCase
  def test_win_from_array_input
    word_guess = WordGuess.new('dogs')
    result = word_guess.try ['a', 'd', 'o', 'z', 's', 'g', 'x']
    assert_equal ['a ****', 'd d***', 'o do**', 
                  'z do**', 's do*s', 'g dogs', 'You win!'], result
  end
  
  def test_lose
    word_guess = WordGuess.new('dogs')
    result = word_guess.try ['a', 'b', 's']
    assert_equal ['a ****', 'b ****', 's ***s', 'You lose!'], result
  end
  
  def test_win_from_string_input
    word_guess = WordGuess.new('dogs')
    result = word_guess.try 'adozsgx'
    assert_equal ['a ****', 'd d***', 'o do**', 
                  'z do**', 's do*s', 'g dogs', 'You win!'], result
  end
end