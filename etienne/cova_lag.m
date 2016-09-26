function [covlag_XY,Covlag_XY,pairs_m] = cova_lag(XX,YY)
% 
% A function that computes the monthly lagged covariance
% of X and Y (Ntime x Nlat x Nlon) with X lagging Y.
%	
% So, if XX is not equal to YY then cova_lag(XX,YY) will not be
%	equal to cova_lag(YY,XX) ... please keep in mind
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
% OUTPUT:		covlag_XY	, monthly lag covariance of X and Y
%											  ((Nmonth choose 2) x Nlat x Nlon).
%						Covlag_XY	, summer-averaged field of the covlag_XY 
%												of the same lag distance.
%											  ((Nmonth choose 2)-1 x Nlat x Nlon).
%						pairs_m		, month pair array, for reference.
%
%	Note that if $Nmonth=3, Nmonth choose 2 = 3.
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
		[junk,XX,junk2] = anomaly(XX); 
	end
	
	if meanYY>tol;
		disp('$$$ YY is not an anomaly field ... computing YY');
		[junk,YY,junk2] = anomaly(YY); 
	end

			% The possible pairs in-between months
		tmp = [1:Nmonth];									% $Nmonth summer months
		pairs_m = combntns(tmp,2);			
		Npair_m = length(pairs_m(:,1));

			%% In MATLAB, combntns outputs all combinaisons 
			 % holding the first entry (i.e. 1) constant then
			 % moves to entry 2 and so on ...

			% pre-allocationg the covariance array.
			% note that it has (Nmonth choose 2) time entries.
		tmp_cov = repmat(NaN,[Npair_m,Nlat,Nlon]);		

			% reshaping column-wise with the summer month # 
			% as the first index.
		XX4d = reshape(XX,Nmonth,Nyear,Nlat,Nlon);
		YY4d = reshape(YY,Nmonth,Nyear,Nlat,Nlon);

			% looping through the possible month pairs
		for it=1:Npair_m

				% allocating the month pairs
			monthX = pairs_m(it,1);
			monthY = pairs_m(it,2);
		
				% squeezing to only one month
			tmpXX = sqz(XX4d(monthX,:,:,:));
			tmpYY = sqz(YY4d(monthY,:,:,:));

				% computing the (unbiased) covariance between 
				%	seperate months --> using sqmean.m ,
			tmp_cov(it,:,:) = Nyear/(Nyear-1)*sqmean(tmpXX.*tmpYY);
																										% (Nlat x Nlon)
		
		end

			% outputting tmp_cov as covlag_XY
		covlag_XY = tmp_cov;				 % (Nmonth choose 2) x Nlat x Nlon)

			%	average the 1-month lag entries of cov_XY
		Cov_XY = repmat(NaN,[2,Nlat,Nlon]);
		Cov_XY(1,:,:) = (sqz(tmp_cov(1,:,:))+sqz(tmp_cov(3,:,:)))./2;
		Cov_XY(2,:,:) = tmp_cov(2,:,:);
		Covlag_XY = Cov_XY;

			%% This works only if $Nmonth=3.
			%% Make more general in the future ...
		
		%% Sqrt(Cov_XY^2) removes the sign. 
		%% Actually, the proper way the average across all month would be
		%% to average the cov_X and cov_Y as in plot_summeravg.m 
		%% an then compute the ratio with cov_XY ...

end


