import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface _SERVICE {
  'getBTCPrice' : ActorMethod<[], number>,
  'setBTCPrice' : ActorMethod<[number], string>,
}
