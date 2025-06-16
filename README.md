# usdb-protocol
“USDB – A BTC-backed stablecoin using runes on ICP
# USDB Protocol 🪙

A BTC-backed stablecoin protocol using Runes and built on the Internet Computer.

## 🧩 Project Structure

- `contracts/`: Smart contracts (Motoko or Rust)
- `oracle/`: Chain Key BTC & HTTPS oracle logic
- `metadata/`: Rune metadata format and logic
- `tests/`: Unit tests and simulation scripts
- `docs/`: Whitepaper, architecture, technical specs
- `diagrams/`: System architecture diagrams
- `scripts/`: Deployment or helper scripts

  🔹 Metadata Module 

Smart contract written in Motoko to manage USDB rune metadata.

Features:

	Add new rune metadata

	Query individual rune

	List all runes

	Handles upgrade persistence using stable storage

Schema fields:

	runeID, collateralInfo, issuedAt, owner, status

Status: ✅ Deployed and tested on Motoko Playground

## 🛠️ Quick Start

```bash
dfx start --background
dfx deploy

