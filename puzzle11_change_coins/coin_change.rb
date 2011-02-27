class CoinChange
  def initialize(coin_types)
    @coin_types = coin_types
  end

  def make(amount)
    @coin_types.sort.reverse.inject([]) do |result, coin_type|
      while amount >= coin_type
        result << coin_type
        amount -= coin_type
      end
      result
    end
  end
end
