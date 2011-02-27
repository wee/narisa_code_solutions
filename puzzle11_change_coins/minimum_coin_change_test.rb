require "test/unit"
require "minimum_coin_change"

class MinimumCoinChangeTest < Test::Unit::TestCase
  def test_apply_set
    assert_equal [[1,2]], MinimumCoinChange.new.apply_set(1, [2])
  end

  def test_apply_set_with_multiple_values
    assert_equal [[1,2], [1,3]], MinimumCoinChange.new.apply_set(1, [2, 3])
  end

  def test_apply_set_with_array_values
    assert_equal [[1,1,1], [1,1,7], [1,1,10]], MinimumCoinChange.new.apply_set(1, [[1,1], [1,7], [1,10]])
  end
  
  def test_permutation_for_one_coin
    assert_equal [1, 7, 10], MinimumCoinChange.new([1, 7, 10]).permute(1)
  end

  def test_permutation_with_one_coin_for_two_coin_combination
    assert_equal [[1,1]], MinimumCoinChange.new([1]).permute(2)
  end

  def test_permutation__with_two_coins_for_two_coin_combinatoin
    assert_equal [[1,1], [1,10], [10, 10]], MinimumCoinChange.new([1, 10]).permute(2)
  end

  def test_permutation_with_three_coins_for_two_coin_combinatoin
    assert_equal [[1,1], [1,7], [1,10], [7,7], [7,10], [10,10]], MinimumCoinChange.new([1, 7, 10]).permute(2)
  end

  def test_permutation_with_three_coins_for_three_coin_combination
    assert_equal [[1,1,1], [1,1,7], [1,1,10],
                  [1,7,7], [1,7,10], [1,10,10],
                  [7,7,7], [7,7,10], [7,10,10],
                  [10,10,10]], MinimumCoinChange.new([1, 7, 10]).permute(3)
  end
  
  def test_no_coin
    assert_equal [], MinimumCoinChange.new([25,5,10]).change(1)
  end
  
  def test_one_exact_match
    assert_equal [1], MinimumCoinChange.new([25,5,1,10]).change(1)
  end

  def test_two_coin_types
    assert_equal [5, 10], MinimumCoinChange.new([25,5,1,10]).change(15)
  end

  def test_two_coin_types_with_multiple_coins
    assert_equal [1, 1, 5], MinimumCoinChange.new([25,5,1,10]).change(7)
  end

  def test_multiple_coin_types
    assert_equal [1, 1, 1, 1, 10, 25], MinimumCoinChange.new([25,5,1,10]).change(39)
  end

  def test_with_different_coin_types_returns_minimum_coins
    assert_equal [1, 7, 7], MinimumCoinChange.new([7, 10, 1]).change(15)
  end

end