function [cov_XY,Cov_XY] = cova_inst(XX,YY)
% 
% A function that computes the monthly instantaneous covariances
% of X and Y both (Ntime x Nlat x Nlon). 
%
% Important: arguments XX and YY must be anomalies.
% 
% Notation: covariance functions are denoted as cova_""" 
%						monthly covariance fields (or variables) as cov_""".
%						summer-averaged covariance fields as Cov_""".
% 
% INPUT:	  XX			,	anomalies of X, (Ntime x Nlat x Nlon).
%						YY			,	anomalies of Y, (Ntime x Nlat x Nlon).
%
% OUTPUT:		cov_XY	, monthly instantaneous covariance of X and Y
%											(Nmonth x Nlat x Nlon).
%						Cov_XY	, summer-averaged value of cov_XY
%											 (Nlat x Nlon).
%
% For lagged correlations, use corr_lag.m
% ====================================================================

		% load Nyear via global.mat
	load('global.mat','Ntime','Nyear','Nmonth','Nlat','Nlon');

		% if XX or YY is not anomalies, compute them
	meanXX = abs(nanmean(make1d(XX)));
	meanYY = abs(nanmean(make1d(YY)));
	tol = 1e-16;

	if meanXX>tol;
		disp('$$$ XX is not an anomaly field ... computing XX');
		[junk,XX,sig_X] = anomaly(XX); 
	end
	
	if meanYY>tol;
		disp('$$$ YY is not an anomaly field ... computing YY');
		[junk,YY,sig_Y] = anomaly(YY); 
	end

		% product of the anomalies
	Z = XX.*YY;

		% climatological (unbiased) covariance (Nmonth X Nlon X Nlat)
	cov_XY = Nyear/(Nyear-1)*anomaly(Z);				

		% summer-averaged cov_XY
	Cov_XY = sqmean(cov_XY);

end

