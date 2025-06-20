# USDB Protocol 🪙  
**A BTC-backed stablecoin using Runes on the Internet Computer (ICP)**

USDB is a decentralized stablecoin protocol that issues BTC-collateralized assets in the form of Runes. Built entirely on the Internet Computer, USDB leverages Chain Key Bitcoin, HTTPS outcalls, and Motoko-based smart contracts for verifiable minting, burning, and metadata tracking.

---

## 🧩 Project Structure

- `contracts/`: Smart contracts (Motoko or Rust)
- `oracle/`: Chain Key BTC & HTTPS oracle logic
- `metadata/`: Rune metadata format and logic
- `tests/`: Unit tests and simulation scripts
- `docs/`: Whitepaper, architecture, technical specs
- `diagrams/`: System architecture diagrams
- `scripts/`: Deployment or helper scripts

---

## 🔹 Metadata Module

Smart contract written in Motoko to manage USDB rune metadata.

**Features:**
- Add new rune metadata
- Query individual rune
- List all runes
- Handles upgrade persistence using stable storage

**Schema fields:**
- `runeID`, `collateralInfo`, `issuedAt`, `owner`, `status`

**Status:** ✅ Deployed and tested on Motoko Playground

---

## 🔮 Oracle Canister Integration — USDB Protocol

The `oracle.mo` canister provides a reliable price feed mechanism to the USDB ecosystem. It allows setting and fetching real-time BTC/USD prices, simulating oracle functionality required for minting and validating BTC-backed stablecoins.

---

### 📁 File Structure

usdb-protocol/
├── backend/
│ └── app.mo # Imports and links all canisters
├── oracle/
│ └── oracle.mo # Oracle canister logic
├── metadata/
│ ├── metadata_model.mo # Shared types used in rune metadata
│ └── metadata_store.mo # Handles storage & query of rune metadata
├── dfx.json # Project config for local deployment

swift
Copy
Edit

---

### 📜 oracle.mo — Key Functions

```motoko
actor Oracle {
  stable var btcUsdPrice: Float = 0;

  public func setPrice(price: Float): async Text {
    btcUsdPrice := price;
    return "Price updated";
  };

  public query func getPrice(): async Float {
    return btcUsdPrice;
  };
};
setPrice: Sets the latest BTC/USD price (to be triggered by an authorized actor in production)

getPrice: Returns the current BTC/USD price

🔗 Integration in app.mo
The backend/app.mo actor imports both the MetadataStore and Oracle canisters and can use oracle.getPrice() to validate rune minting or rebalancing logic.

motoko
Copy
Edit
import MetadataStore "canister:metadata_store";
import Oracle "canister:oracle";
⚙ dfx.json Setup
Make sure your dfx.json includes the oracle canister:

json
Copy
Edit
"canisters": {
  "oracle": {
    "main": "oracle/oracle.mo",
    "type": "motoko"
  },
  ...
}
🧪 Testing Locally
To test the oracle locally:

bash
Copy
Edit
dfx start --background
dfx deploy oracle
dfx canister call oracle setPrice '(42000.5)'
dfx canister call oracle getPrice
🛠️ Quick Start
bash
Copy
Edit
dfx start --background
dfx deploy oracle
dfx deploy
