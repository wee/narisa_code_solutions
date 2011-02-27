function CoinChange(coinTypes) {
  this.coinTypes = coinTypes;
  this.make = function(amount) {
    var result = [];
    var coinTypes = this.coinTypes.sort(function(a,b) { return b-a; });
    $(coinTypes).each(function() {
      while (amount >= this) {
        result.push(this);
        amount -= this;
      }
    });
    return result;
  };
}
