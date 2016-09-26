function Var_X = anomaly_Var(XX)
%
% A function that computes the monthly variances of 
% X directly from its anomaly field XX.
%
% Useful when the variance is considered a better scaling than
% the standard deviation e.g. in regression/
%
% INPUT:        XX      , anomaly field of X (Ntime x Nlat x Nlon).
%
% OUTPUT:       Var_X   , monthly unbiassed variance of X
%                           (Nmonth x Nlat x Nlon).
% ===================================================================

    % load Nyear from global.mat
  load('global.mat','Nyear');

    % Just like anomaly_sig.m but w/o the leading sqrt.
    % using anomaly.m
    % Leading factor makes it unbiased.
  Var_X = Nyear/(Nyear-1)*anomaly(XX.*XX);

    %% Note that the above is analytically equivalent to
  % [junk1,junk2,sig_X] = anomaly(XX);

    %% However, it is more susceptible to round off errors (I think).
    
end
