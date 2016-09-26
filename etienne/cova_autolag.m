function [covlag_X,Covlag_X,pairs_m] = cova_autolag(XX)
% 
% A special case of cova_lag with YY=XX and sig_Y=sig_X.
%
% Important: argument XX must be anomaly.
% 
% Notation: covariance functions are denoted as cova_""" 
%						monthly covariance fields (or variables) as cov_""".
%						summer-averaged covariance fields as Cov_""".
% 
% INPUT:	  XX			,	anomalies of X, (Ntime x Nlat x Nlon).
%						sig_X		, stand. dev. of X, (Nmonth x Nlat x Nlon).
%
% OUTPUT:		covlag_XY	, monthly lag correlation of X and Y
%												((Nmonth choose 2) x Nlat x Nlon).
%						Covlag_XY	, summer-averaged field of the corlag_XY 
%												of the same lag distance.
%											  ((Nmonth choose 2)-1 x Nlat x Nlon).
%						pairs_m		, month pair array, for reference.
%
%	Note that if $Nmonth=3, Nmonth choose 2 = 3.
%
% For lagged correlations, use corr_autolag.m
% ====================================================================

		% very simply --> using corr_lag.m
	[tmp1,tmp2,tmp3] = cova_lag(XX,XX);
		
		% assigning the output arguments
	covlag_X = tmp1;
	Covlag_X = tmp2;
	pairs_m = tmp3;

end

