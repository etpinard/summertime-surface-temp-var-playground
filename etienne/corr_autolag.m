function [corlag_X,Corlag_X,pairs_m] = corr_autolag(XX,sig_X,opt)
% 
% A special case of corr_lag with YY=XX and sig_Y=sig_X.
%
% Important: argument XX must be anomaly.
% 
% Notation: correlation functions are denoted as corr_""". 
%           monthly correlation fields (or variables) as cor_""".
%           summer-averaged correlation fields as Cor_""".
% 
% INPUT:    XX      , anomalies of X, (Ntime x Nlat x Nlon).
%           sig_X   , stand. dev. of X, (Nmonth x Nlat x Nlon).
%           opt     , set to 'sqz1' to have only 1-month lag sheet in 
%                     output `Corlag_X'.
%
% OUTPUT:   corlag_XY , monthly lag correlation of X and Y
%                       ((Nmonth choose 2) x Nlat x Nlon).
%           Corlag_XY , summer-averaged field of the corlag_XY 
%                       of the same lag distance.
%                       ((Nmonth choose 2)-1 x Nlat x Nlon).
%           pair_m    , month pair array, for reference.
%
% Note that if $Nmonth=3, Nmonth choose 2 = 3.
%
% For lagged covariances, use cova_autolag.m
% ====================================================================

  % very simply --> using corr_lag.m
  [tmp1,tmp2,tmp3] = corr_lag(XX,XX,sig_X,sig_X);

  % assigning the output arguments
  corlag_X = tmp1;
  pairs_m = tmp3;

  % optional output, squeeze first sheet of `Corlag_X'
  if strcmp(opt,'sqz1')
    Corlag_X = sqz(tmp2(1,:,:));
  else
    Corlag_X = tmp2;
  end

end
