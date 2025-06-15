import Mint "mint";
import Burn "burn";
import Collateral "collateral";

actor {
  public func mintUSDB(amount: Nat, btcCollateral: Nat) : async Text {
    if (Collateral.validateCollateral(btcCollateral, amount)) {
      return await Mint.mint(amount, btcCollateral);
    } else {
      return "Insufficient collateral";
    }
  };

  public func burnUSDB(tokenId: Text) : async Bool {
    return await Burn.burn(tokenId);
  };
}
