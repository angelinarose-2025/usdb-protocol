import Time "mo:base/Time";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";

// Simulating inter-canister call (collateral actor interface)
actor class BurnActor() {

  // === Rune Metadata Type (duplicate from mint.mo for now) ===
  type Rune = {
    runeID : Text;
    collateralBTC : Text;
    mintedAt : Time.Time;
    status : Text;
    owner : Principal;
    btcTxHash : Text;
  };

  // === Storage (must sync with mint.mo) ===
  stable var runeStoreData : [(Text, Rune)] = [];

  var runeStore : HashMap.HashMap<Text, Rune> = HashMap.HashMap<Text, Rune>(10, Text.equal, Text.hash);

  system func preupgrade() {
    runeStoreData := Iter.toArray(runeStore.entries());
  };

  system func postupgrade() {
    runeStore := HashMap.HashMap<Text, Rune>(10, Text.equal, Text.hash);
    for ((k, v) in runeStoreData.vals()) {
      runeStore.put(k, v);
    };
  };

  // === Simulated Import for Collateral Interface ===
  let collateral = actor "aaaaa-aa" : actor {
    removeCollateral : shared (Text) -> async Bool;
  };

  // === Burn a Rune ===
  public shared(msg) func burnRune(runeID : Text) : async Text {
    let caller = msg.caller;

    let runeOpt = runeStore.get(runeID);
    switch (runeOpt) {
      case (null) {
        return "Error: Rune not found.";
      };
      case (?rune) {
        if (rune.owner != caller) {
          return "Error: You are not the owner.";
        };

        // Simulate collateral unlock
        let _ = await collateral.removeCollateral(runeID);

        // Update status
        let updatedRune : Rune = {
          runeID = rune.runeID;
          collateralBTC = rune.collateralBTC;
          mintedAt = rune.mintedAt;
          status = "burned";
          owner = rune.owner;
          btcTxHash = rune.btcTxHash;
        };
        runeStore.put(runeID, updatedRune);

        return "Rune " # runeID # " burned successfully.";
      };
    };
  };

  // === Query Rune ===
  public query func getRune(runeID : Text) : async ?Rune {
    return runeStore.get(runeID);
  };

}
