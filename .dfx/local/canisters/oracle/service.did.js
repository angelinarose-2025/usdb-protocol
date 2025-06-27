export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'getBTCPrice' : IDL.Func([], [IDL.Float64], ['query']),
    'setBTCPrice' : IDL.Func([IDL.Float64], [IDL.Text], []),
  });
};
export const init = ({ IDL }) => { return []; };
