describe("CoinChange", function() {

  describe("For coins: [25,5,1,10]", function() {
  var coinChange;

    beforeEach(function() {
      coinChange = new CoinChange([25,5,1,10]);
    });

    it("should be empty if there is no amount", function() {
      expect(coinChange.make(0)).toEqual([]);
    });

    it("should be one exact coin if there is an exact match", function() {
      expect(coinChange.make(1)).toEqual([1]);
    });

    it("should be two coins if they match the amount", function() {
      expect(coinChange.make(15)).toEqual([10, 5]);
    });

    it("should be two coin types with multiple coins if they match the amount", function() {
      expect(coinChange.make(7)).toEqual([5, 1, 1]);
    });

    it("should be multiple coin types with multiple coins if they match the amount", function() {
      expect(coinChange.make(39)).toEqual([25, 10, 1, 1, 1, 1]);
    });
  });

  describe("For coins: [7,1,10]", function() {
  var coinChange;

    beforeEach(function() {
      coinChange = new CoinChange([7, 1, 10]);
    });

    it("should be correct for these coin types", function() {
      expect(coinChange.make(15)).toEqual([10, 1, 1, 1, 1, 1]);
    });
  });
});
