require 'test/unit'
require 'coin_change'

class CoinChangeTest < Test::Unit::TestCase
  def test_no_coin
    assert_equal [], CoinChange.new([25,5,1,10]).make(0)
  end

  def test_one_exact_match
    assert_equal [1], CoinChange.new([25,5,1,10]).make(1)
  end

  def test_two_coin_types
    assert_equal [10, 5], CoinChange.new([25,5,1,10]).make(15)
  end

  def test_two_coin_types_with_multiple_coins
    assert_equal [5, 1, 1], CoinChange.new([25,5,1,10]).make(7)
  end

  def test_multiple_coin_types
    assert_equal [25, 10, 1, 1, 1, 1], CoinChange.new([25,5,1,10]).make(39)
  end

  def test_with_different_coin_types
    assert_equal [10, 1, 1, 1, 1, 1], CoinChange.new([7, 10, 1]).make(15)
  end
end
