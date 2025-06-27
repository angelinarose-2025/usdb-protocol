module {
  public type CollateralInfo = {
    btcAmount : Float; 
    txHash : Text;
    owner : Principal;
  };

  public type RuneMetadata = {
    runeID : Text;
    collateralInfo : CollateralInfo;
    mintedAt : Int;
    status : Text;
    owner : Principal;
  };
};
