import Debug "mo:base/Debug";
import Float "mo:base/Float";

actor Oracle {
  stable var btcPrice: Float = 67000.0;

  public query func getBTCPrice(): async Float {
    btcPrice;
  };

  public func setBTCPrice(newPrice: Float): async Text {
    if (newPrice <= 0) {
      return "Price must be greater than 0";
    };
    btcPrice := newPrice;
    Debug.print("BTC price updated to: " # Float.toText(btcPrice));
    return "BTC price updated successfully";
  };
}
