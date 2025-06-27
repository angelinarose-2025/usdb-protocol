import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface CollateralInfo {
  'owner' : Principal,
  'txHash' : string,
  'btcAmount' : number,
}
export interface RuneMetadata {
  'status' : string,
  'owner' : Principal,
  'runeID' : string,
  'collateralInfo' : CollateralInfo,
  'mintedAt' : bigint,
}
export interface _SERVICE {
  'estimateUSDBValue' : ActorMethod<[RuneMetadata], number>,
  'getBTCPriceUSD' : ActorMethod<[], number>,
  'ping' : ActorMethod<[], string>,
}
