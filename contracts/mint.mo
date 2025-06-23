import Time "mo:base/Time";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";

actor class MintActor() {

  // === Rune Metadata Type ===
  type Rune = {
    runeID : Text;
    collateralBTC : Text;
    mintedAt : Time.Time;
    status : Text;            // e.g., "circulating"
    owner : Principal;
    btcTxHash : Text;
  };

  // === Storage for Runes ===
  stable var runeCounter : Nat = 0;
  stable var runeStoreEntries : [(Text, Rune)] = [];

  private var runeStore : HashMap.HashMap<Text, Rune> = HashMap.HashMap<Text, Rune>(10, Text.equal, Text.hash);

  system func preupgrade() {
    runeStoreEntries := Iter.toArray(runeStore.entries());
  };

  system func postupgrade() {
    runeStore := HashMap.HashMap<Text, Rune>(10, Text.equal, Text.hash);
    for ((k, v) in runeStoreEntries.vals()) {
      runeStore.put(k, v);
    };
  };

  // === Simulated Oracle Price Feed (to be replaced with real) ===
  public query func getBTCPriceUSD() : async Nat {
    // Mock value, e.g., 1 BTC = $66,000
    return 66000;
  };

  // === Mint Function ===
  public shared(msg) func mintRune(btcAmount : Text, btcTxHash : Text) : async Text {
    let caller = msg.caller;

    // In a real implementation, validate BTC tx here with Chain Key BTC
    Debug.print("Mint requested by " # Principal.toText(caller));
    Debug.print("BTC Amount: " # btcAmount);
    Debug.print("BTC Tx: " # btcTxHash);

    // Generate unique rune ID
    runeCounter += 1;
    let newRuneID = "usdb-" # Nat.toText(runeCounter);

    // Create metadata
    let newRune : Rune = {
      runeID = newRuneID;
      collateralBTC = btcAmount;
      mintedAt = Time.now();
      status = "circulating";
      owner = caller;
      btcTxHash = btcTxHash;
    };

    // Save to store
    runeStore.put(newRuneID, newRune);

    return "Minted Rune ID: " # newRuneID;
  };

  // === Query Rune Metadata ===
  public query func getRune(runeID : Text) : async ?Rune {
    return runeStore.get(runeID);
  };

  // === Query All Rune IDs ===
  public query func getAllRuneIDs() : async [Text] {
    return Iter.toArray(runeStore.keys());
  };

};
