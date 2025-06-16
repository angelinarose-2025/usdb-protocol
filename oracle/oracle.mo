import Debug "mo:base/Debug";
import Float "mo:base/Float";

actor Oracle {

  // 🪙 Stable BTC price storage (initial value: $67,000)
  stable var btcPrice: Float = 67000.0;

  /// 📈 Returns the current mocked BTC price
  public query func getBTCPrice(): async Float {
    btcPrice
  };

  /// 🛠 Admin-only function to manually update the price (for testing)
  public func setBTCPrice(newPrice: Float): async Text {
    if (newPrice <= 0) {
      return "Price must be greater than 0";
    };
    btcPrice := newPrice;
    Debug.print("BTC price updated to: " # Float.toText(btcPrice));
    return "BTC price updated successfully";
  };
}
