import Oracle "../oracle/oracle";
import MetadataModel "../metadata/metadata_model";

actor USDBCanister {

  // Type aliases for convenience
  type RuneMetadata = MetadataModel.RuneMetadata;
  type CollateralInfo = MetadataModel.CollateralInfo;

  // Call the oracle’s getPrice function
  public query func getBTCPriceUSD(): async Float {
    Oracle.getPrice()
  };

  // Example function using both metadata and oracle
  public func estimateUSDBValue(rune: RuneMetadata): async Float {
    let btcPrice = await getBTCPriceUSD();
    return rune.collateralInfo.btcAmount * btcPrice;
  };

  // Just to test if everything's wired up
  public query func ping(): async Text {
    "Canister is live!"
  };
};