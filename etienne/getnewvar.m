function [X,Xbar,XX,mag_XX] = ...
                        getnewvar(var_full,opt_anom_Var,months_only)
%
% A function that automate the extraction of a "new" variable.  Calls
% getnetcdf.m , summer_only, (NEW!) uses Iland (from global.mat) to
% trim the array and then calls anomaly.m .
%
%
% INPUT:    var_full    , string of $var_full.cdf
%                           e.g. var_full = 'tas' for the 2m
%                           temperature.
%           opt_anom_Var, (optional) to accomodate Var_X 
%           months_only, NEW! (optional) first and last month to
%                        include for the NH. 
%                        By default, months_only=[6,8].
%                        'winter only' = [-1,1];
%
% OUTPUT:   X       , the full output array. (Ntime x Nlat x Nlon)
%           Xbar    , monthly clim. mean values (Nmonth x Nlat x Nlon)
%           XX      , anomalies of X  (Ntime x Nlat x Nlon).
%           mag_XX  , monthly standard deviation (Nmonth x Nlat x Nlon)
%                   , or monthly variance
% =====================================================================


  % Load Nyear from global.mat
  load('global.mat','Nyear','Iland');
  
  % extract $var_full using getnetcdf.m (opt_dump is n/a here)
  tmp = getnetcdf(var_full);          
  
    % trim data to summer-only  using summer_only.m
  if nargin==3 

    % if months are intended to be different than summer_only
    m1 = months_only(1);
    m2 = months_only(2);

    if ~(m1==1 & m2==12)

      disp(['$$$ Trimming ... ', var_full, '.cdf to months ', ...
            num2str(m1) ' and ' num2str(m2) ]);

    end

    disp(['$$$ SH lags NH by 6 months']);

    tmp = summer_only(tmp,m1,m2,Nyear); 

  else

    % By default, JJA and DJF
    disp(['$$$ Trimming ... ', var_full, '.cdf']);
    tmp = summer_only(tmp,6,8,Nyear);

  end


  % get number of time entries of trimming
  Ntime = size(tmp,1);

  % trim using Iland computed in land_only.m
  tmp = x2d(Iland,Ntime).*tmp;

    
  % output the full variable
  X = tmp;


  % compute anomalies of X, if required
  if nargout >= 2

    disp(['$$$ Computing ... ', var_full, '.cdf']);

    if nargin>=2 && strcmp(opt_anom_Var,'Var')

      [Xbar,XX,mag_XX] = anomaly(X,opt_anom_Var);

    else

      [Xbar,XX,mag_XX] = anomaly(X);

    end

  end
  
end
