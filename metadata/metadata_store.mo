import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

actor MetadataStore {

  type CollateralInfo = {
    btcAmount: Float;
    btcTxHash: Text;
  };

  type RuneMetadata = {
    runeID: Text;
    collateralInfo: CollateralInfo;
    issuedAt: Text;
    owner: Text;
    status: Text;
  };

  // Use a stable array to persist data across upgrades
  stable var runeStoreEntries : [(Text, RuneMetadata)] = [];

  // In-memory HashMap for fast access
  let runeStore = HashMap.HashMap<Text, RuneMetadata>(10, Text.equal, Text.hash);

  // Restore HashMap from stable entries on canister initialization
  system func postupgrade() {
    for ((k, v) in runeStoreEntries.vals()) {
      runeStore.put(k, v);
    };
    runeStoreEntries := [];
  };

  // Save HashMap entries to stable array before upgrade
  system func preupgrade() {
    runeStoreEntries := Iter.toArray(runeStore.entries());
  };

  public func addRune(rune: RuneMetadata): async Text {
    if (runeStore.get(rune.runeID) != null) {
      return "Rune already exists";
    };
    runeStore.put(rune.runeID, rune);
    return "Rune added successfully";
  };

  public query func getRune(runeID: Text): async ?RuneMetadata {
    runeStore.get(runeID)
  };

  public query func listRunes(): async [RuneMetadata] {
    Iter.toArray(
      Iter.map<(Text, RuneMetadata), RuneMetadata>(
        runeStore.entries(),
        func ((_, v)) = v
      )
    )
  };
};