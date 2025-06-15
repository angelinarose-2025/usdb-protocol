module {
  public func validateCollateral(btcAmount: Nat, usdbAmount: Nat) : Bool {
    // Example: 150% collateral ratio
    return btcAmount * 100 >= usdbAmount * 150;
  }
}
