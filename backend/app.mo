// === Imports ===
import Oracle "canister:oracle";
import MetadataModel "../metadata/metadata_model/lib";

import Float "mo:base/Float";
import Debug "mo:base/Debug";
import Text "mo:base/Text";

actor USDBCanister {

  // === Type Aliases ===
  type RuneMetadata = MetadataModel.RuneMetadata;
  type CollateralInfo = MetadataModel.CollateralInfo;

  // === Oracle Integration ===
  /// Gets the current BTC/USD price
  public func getBTCPriceUSD(): async Float {
    await Oracle.getBTCPrice();
  };

  // === USDB Value Estimation ===
  /// Estimates the USD value of a Rune based on BTC collateral
  public func estimateUSDBValue(rune: RuneMetadata): async Float {
    let btcPrice = await Oracle.getBTCPrice();
    let btcVal = rune.collateralInfo.btcAmount;

    let estimatedValue = btcVal * btcPrice;

    Debug.print("BTC Amount: " # Float.toText(btcVal));
    Debug.print("BTC Price: " # Float.toText(btcPrice));
    Debug.print("Estimated USD Value: " # Float.toText(estimatedValue));

    return estimatedValue;
  };

  // === Health Check ===
  public query func ping(): async Text {
    "Canister is live!"
  };
}
