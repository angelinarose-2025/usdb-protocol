# USDB: BTC-Backed Stablecoin on the Internet Computer

---

## 1. Introduction

### Why a BTC-backed stablecoin?

Stablecoins are essential for on-chain utility, yet most are USD-backed and live on Ethereum or centralized blockchains. USDB introduces a Bitcoin-collateralized stablecoin directly on the Internet Computer (ICP), offering decentralized issuance, programmability, and Bitcoin-native backing.

### What are Runes and REE?

Runes are Bitcoin-native tokens introduced via the Runes protocol. REE (Rune Execution Environment) is an abstraction for executing logic tied to runes—enabling programmability and collateral tracking on smart contract platforms. USDB uses REE principles to structure its metadata, issuance logic, and lifecycle management.

---

## 2. Protocol Overview

### Minting and Burning Flow

Users lock BTC via Chain Key Bitcoin. Upon confirmation, the USDB protocol mints a new rune with embedded metadata and issues an equivalent USDB token on ICP. Burning reverses this: USDB is sent to a burn address, the rune metadata is marked inactive, and the BTC is released.

📊 **See: Diagram 1 — Minting and Collateral Flow**  
Located at: `diagrams/minting and collateral flow diagram.png`

This flowchart illustrates how USDB is minted from BTC deposits, showing user interaction, oracle confirmation, and token issuance.

### Collateralization Strategy

USDB maintains full BTC collateralization. All minted tokens must correspond to BTC locked via verified on-chain proofs or via HTTPS oracle confirmations, ensuring verifiable 1:1 backing.

---

## 3. Architecture

### Contracts & Oracles

- **Smart Contracts (Motoko or Rust):** Handle minting, burning, metadata, and user balances.
- **Oracles:** Integrate with ICP’s HTTPS outcalls and Chain Key Bitcoin for verifying BTC transactions.

### Metadata Format for Runes

Each rune has structured metadata:

- `runeID`: Unique identifier  
- `collateralInfo`: BTC amount, lock details  
- `issuedAt`: Timestamp  
- `owner`: User principal  
- `status`: Active, Burned, Revoked  

Persistent storage ensures metadata survives upgrades and supports listing/querying.

📊 **See: Diagram 2 — Rune Life Cycle**  
Located at: `diagrams/Rune Life cycle.png`

This diagram shows how rune metadata transitions between states (Active → Burned → Revoked), capturing the lifecycle over time.

---

## 4. Oracle Integration

### HTTPS Outcalls

Used to query BTC transactions if Chain Key BTC is delayed or unavailable. Verifies deposits to BTC locking addresses before minting USDB.

### Fallback Handling

Chain Key BTC is the primary source. If unavailable, the system temporarily falls back to HTTPS oracles with hash-based verification and a multi-source check to mitigate spoofing.

---

## 5. Security Measures

### Collateral Checks

Every USDB minted is backed by BTC verified on-chain or via oracle. No fractional minting is allowed.

### Input Validation

- Owner principal is checked on mint/burn  
- Timestamps are bounded to prevent replay attacks  
- Metadata integrity is validated on creation and updates

---

## 6. Testing Plan

### Unit and Integration Testing

- **Unit Tests:** Smart contract logic (mint, burn, metadata).
- **Integration Tests:** Simulated mint-burn flows with mocked oracles.

Manual testing on Motoko Playground and local dfx environment ensures correctness.

---

## 7. Roadmap

### Milestone 2: Governance, UI, and More

- Governance module for voting on parameter changes (e.g., mint limits)  
- Frontend UI for interacting with USDB contracts  
- Ledger integration for USDB as a token standard  
- Community testing and incentivized bug bounties

---

## Appendix

📊 **Diagram 3 — Burn and Redemption Flow**  
Located at: `diagrams/Burn and redemption flow diagram.png`

This diagram depicts the full redemption lifecycle: from USDB being burned by a user to BTC being unlocked and rune metadata being marked inactive.

---

