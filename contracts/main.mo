import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Debug "mo:base/Debug";

// === Rune Summary (optional compact type) ===
type RuneSummary = {
  runeID : Text;
  owner : Principal;
  status : Text;
  collateralBTC : Text;
};

// === Interfaces to other canisters ===

let mintCanister = actor "aaaaa-aa" : actor {
  mintRune : shared (Text, Text) -> async Text;
  getRune : query (Text) -> async ?{
    runeID : Text;
    collateralBTC : Text;
    mintedAt : Int;
    status : Text;
    owner : Principal;
    btcTxHash : Text;
  };
  getAllRuneIDs : query () -> async [Text];
};

let burnCanister = actor "bbbbb-bb" : actor {
  burnRune : shared (Text) -> async Text;
  getRune : query (Text) -> async ?{
    runeID : Text;
    collateralBTC : Text;
    mintedAt : Int;
    status : Text;
    owner : Principal;
    btcTxHash : Text;
  };
};

let collateralCanister = actor "ccccc-cc" : actor {
  getCollateral : query (Text) -> async ?{
    btcAmount : Text;
    txHash : Text;
    owner : Principal;
  };
};

// === Main Actor ===

actor Main {

  // === Mint Interface ===
  public shared(msg) func mint(runeBTC : Text, txHash : Text) : async Text {
    Debug.print("Routing to Mint...");
    return await mintCanister.mintRune(runeBTC, txHash);
  };

  // === Burn Interface ===
  public shared(msg) func burn(runeID : Text) : async Text {
    Debug.print("Routing to Burn...");
    return await burnCanister.burnRune(runeID);
  };

  // === View Rune Summary ===
  public shared(msg) func getRuneInfo(runeID : Text) : async ?RuneSummary {
    let optRune = await mintCanister.getRune(runeID);
    switch (optRune) {
      case (null) return null;
      case (?rune) {
        return ?{
          runeID = rune.runeID;
          collateralBTC = rune.collateralBTC;
          owner = rune.owner;
          status = rune.status;
        };
      };
    };
  };

  // === List All Rune IDs ===
  public shared(msg) func listAllRunes() : async [Text] {
    return await mintCanister.getAllRuneIDs();
  };

  // === Get Collateral Info for Rune ===
  public shared(msg) func getCollateralInfo(runeID : Text) : async ?Text {
    let optInfo = await collateralCanister.getCollateral(runeID);
    switch (optInfo) {
      case (null) return null;
      case (?info) return ?("BTC Amount: " # info.btcAmount # " | Tx: " # info.txHash);
    };
  };

}
