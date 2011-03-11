class MinimumCoinChange
  attr_reader :coin_types

  def initialize(coin_types = [])
    @coin_types = coin_types
  end

  def change(amount)
    digits = 1
    while true
      minimum = amount + 1
      permute(digits, coin_types.sort).map do |coins|
        sum = [coins].flatten.inject(0) { |sum, coin| sum + coin }
        return [coins].flatten if sum == amount
        minimum = sum if sum < minimum
      end
      break if minimum > amount
      digits += 1
    end
    []
  end

  def permute(digits, coins = coin_types)
    return coins.map { |coin| coin } if digits == 1
    result = []
    tail = coins.dup
    coins.each do |coin|
      result += apply_set(coin, permute(digits - 1, tail))
      tail.shift
    end
    result
  end

  def apply_set(first, set)
    ([first] * set.count).zip(set).map(&:flatten)
  end
end