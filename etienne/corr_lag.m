function [corlag_XY,Corlag_XY,pairs_m] = ...
  corr_lag(XX,YY,sig_X,sig_Y,opt)
% 
% A function that computes the monthly lagged correlation
% of X and Y (Ntime x Nlat x Nlon) with X lagging Y.
% 
% So, if XX is not equal to YY then corr_lag(XX,YY) will not be
% equal to corr_lag(YY,XX) ... please keep in mind
%
% Important: arguments XX and YY must be anomalies.
% 
% Notation: correlation functions are denoted as corr_""". 
%           monthly correlation fields (or variables) as cor_""".
%           summer-averaged correlation fields as Cor_""".
% 
% INPUT:    XX      , anomalies of X, (Ntime x Nlat x Nlon).
%           YY      , anomalies of Y, (Ntime x Nlat x Nlon).
%           sig_X   , stand. dev. of X, (Nmonth x Nlat x Nlon).
%           sig_Y   , stand. dev. of Y, (Nmonth x Nlat x Nlon)
%                     if sig_X or sig_Y is empty (i.e = [])
%                     they will be computed here.
%           opt     , set to 'sqz1' to have only 1-month lag sheet in 
%                     output `Corlag_XY'.
%
% OUTPUT:   corlag_XY , monthly lag correlation of X and Y
%                       ((Nmonth choose 2) x Nlat x Nlon).
%           Corlag_XY , summer-averaged field of the corlag_XY 
%                       of the same lag distance.
%                       ((Nmonth choose 2)-1 x Nlat x Nlon).
%           pairs_m   , month pair array, for reference.
%
% Note that if $Nmonth=3, Nmonth choose 2 = 3.
%
% For lagged covariances, use cova_lag.m
% ====================================================================

    % loading via global.mat
  load('global.mat','Nyear','Ntime','Nmonth','Nlat','Nlon');

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

    % if sig_X is empty, compute it
  if isempty(sig_X);
    sig_X = anomaly_sig(XX);
  end
    
    % if sig_Y is empty, compute it
  if isempty(sig_Y);
    sig_Y = anomaly_sig(YY);
  end
  
    % The possible pairs in-between months
  tmp = [1:Nmonth];                 % $Nmonth summer months
  pairs_m = combntns(tmp,2);      
  Npair_m = length(pairs_m(:,1));

    %% In MATLAB, combntns outputs all combinaisons 
     % holding the first entry (i.e. 1) constant then
     % moves to entry 2 and so on ...

    % pre-allocationg the correlation array.
    % note that it has (Nmonth choose 2) time entries.
  tmp_cor = repmat(NaN,[Npair_m,Nlat,Nlon]);    

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
      % seperate months --> using sqmean.m ,
    cov_XY = Nyear/(Nyear-1)*sqmean(tmpXX.*tmpYY); % (Nlat x Nlon)
    
      % squeezing the respective monthly std's
    sig_X1 = sqz(sig_X(monthX,:,:));               % (Nlat x Nlon)
    sig_Y1 = sqz(sig_Y(monthY,:,:));

      % filling the correlation array
    tmp_cor(it,:,:) =  cov_XY./(sig_X1.*sig_Y1);   % (Nlat x Nlon)
  
  end

    % outputting tmp_cor as corlag_XY
  corlag_XY = tmp_cor;         % (Nmonth choose 2) x Nlat x Nlon)

    % average the 1-month lag entries of corlag_XY
  Cor_XY = repmat(NaN,[2,Nlat,Nlon]);
  Cor_XY(1,:,:) = (sqz(tmp_cor(1,:,:))+sqz(tmp_cor(3,:,:)))./2;
  Cor_XY(2,:,:) = tmp_cor(2,:,:);
  
  % optional output, squeeze first sheet of `Corlag_X'
  if nargin==5 && strcmp(opt,'sqz1')
    Corlag_XY = sqz(Cor_XY(1,:,:));
  else
    Corlag_XY = Cor_XY;
  end

    %% This works only if $Nmonth=3.
    %% Make more general in the future ...
    
    %% Sqrt(Cor_XY^2) removes the sign. 
    %% Actually, the proper way the average across all month would be
    %% to average the cov_X and cov_Y as in plot_summeravg.m 
    %% an then compute the ratio with cov_XY ...

end
