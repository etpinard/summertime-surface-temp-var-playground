function [cor_XY,Cor_XY] = corr_inst(XX,YY,sig_X,sig_Y)
% 
% A function that computes the monthly instantaneous correlations
% of X and Y both (Ntime x Nlat x Nlon). 
%
% Important: arguments XX and YY must be anomalies.
% 
% Notation: correlation functions are denoted as corr_""" 
%           monthly correlation fields (or variables) as cor_""".
%           summer-averaged correlation fields as Cor_""".
% 
% INPUT:    XX      , anomalies of X, (Ntime x Nlat x Nlon).
%           YY      , anomalies of Y, (Ntime x Nlat x Nlon).
%           sig_X   , stand. dev. of X, (Nmonth x Nlat x Nlon).
%           sig_Y   , stand. dev. of Y, (Nmonth x Nlat x Nlon)
%                     if sig_X or sig_Y is empty (i.e = [])
%                     they will be computed here.
%
% OUTPUT:   cor_XY  , monthly instantaneous correlation of X and Y
%                     (Nmonth x Nlat x Nlon).
%           Cor_XY  , summer-averaged value of cor_XY
%                     (Nlat x Nlon).
%
% For lagged covariances, use cova_lag.m
% ====================================================================
    
    % loading via global.mat
  load('global.mat','Ntime','Nyear','Nmonth','Nlat','Nlon');

    % if XX or YY is not anomalies, compute them
  meanXX = abs(nanmean(make1d(XX)));
  meanYY = abs(nanmean(make1d(YY)));
  tol = 1e-10;

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

    % product of the anomalies
  Z = XX.*YY;

    % climatological (unbiased) covariance (Nmonth X Nlon X Nlat)
  cov_XY = Nyear/(Nyear-1)*anomaly(Z);        

    % correlation coefficient 
  cor_XY =  cov_XY./(sig_X.*sig_Y);
    
    % summer-averaged cor_XY (column-wise through the months)
  Cor_XY = sqmean(cor_XY);

    %% Actually, the proper way the average across all month would be
    %% to average the cov_X and cov_Y as in plot_summeravg.m 
    %% an then compute the ratio with cov_XY ...

end
