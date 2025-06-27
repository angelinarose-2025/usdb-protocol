export const idlFactory = ({ IDL }) => {
  const CollateralInfo = IDL.Record({
    'owner' : IDL.Principal,
    'txHash' : IDL.Text,
    'btcAmount' : IDL.Float64,
  });
  const RuneMetadata = IDL.Record({
    'status' : IDL.Text,
    'owner' : IDL.Principal,
    'runeID' : IDL.Text,
    'collateralInfo' : CollateralInfo,
    'mintedAt' : IDL.Int,
  });
  return IDL.Service({
    'estimateUSDBValue' : IDL.Func([RuneMetadata], [IDL.Float64], []),
    'getBTCPriceUSD' : IDL.Func([], [IDL.Float64], []),
    'ping' : IDL.Func([], [IDL.Text], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
