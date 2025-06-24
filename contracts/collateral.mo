import Text "mo:base/Text";
import Iter "mo:base/Iter";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";

actor Collateral {

  // === Type ===
  type CollateralInfo = {
    btcAmount : Text;     // Represented as string for precision
    txHash : Text;
    owner : Principal;
  };

  // === State ===
  stable var collateralEntries : [(Text, CollateralInfo)] = [];

  var collateralMap : HashMap.HashMap<Text, CollateralInfo> = HashMap.HashMap<Text, CollateralInfo>(10, Text.equal, Text.hash);

  system func preupgrade() {
    collateralEntries := Iter.toArray(collateralMap.entries());
  };

  system func postupgrade() {
    collateralMap := HashMap.HashMap<Text, CollateralInfo>(10, Text.equal, Text.hash);
    for ((k, v) in collateralEntries.vals()) {
      collateralMap.put(k, v);
    };
  }

  // === Add Collateral ===
  public shared(msg) func addCollateral(runeID : Text, btcAmount : Text, txHash : Text) : async Bool {
    let caller = msg.caller;

    let info : CollateralInfo = {
      btcAmount = btcAmount;
      txHash = txHash;
      owner = caller;
    };

    collateralMap.put(runeID, info);
    Debug.print("Collateral added for Rune " # runeID);
    return true;
  };

  // === Remove Collateral (on burn) ===
  public shared func removeCollateral(runeID : Text) : async Bool {
    ignore collateralMap.remove(runeID);
    Debug.print("Collateral removed for Rune " # runeID);
    return true;
  };

  // === Query Collateral Info ===
  public query func getCollateral(runeID : Text) : async ?CollateralInfo {
    return collateralMap.get(runeID);
  };

  // === Query All Collateral IDs ===
  public query func getAllRuneIDs() : async [Text] {
    return Iter.toArray(collateralMap.keys());
  };

}
