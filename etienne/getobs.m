function X = getobs(var,Nlat,Nlon,model_name)
%
% To do ... but see how this plays out first ...
% 
% INPUT:        var_full    , string of $var_full.cdf
%                               e.g. var_full = 'tas' for the 2m
%                               temperature.
%               Nlat,Nlon   , output resolution
%             
%
% OUTPUT:       X           , the output MATLAB array.
% ===================================================================


  % determine path and infile name from input 
  switch var

    case 'T'; var_string = 'air'; var_short = 'tas';

    case 'P'; var_string = 'precip'; var_short = 'p';
    % to be completed

  end
% ----------------------------------------------------------------------
  
  % Need `Ntime and `Nland'
  load('global.mat','Ntime','Nyear','Nland','Iland');

  % Datapath for the observations
  datapath_obs = '/home/disk/p/etienne/nobackup/data/obs/';

  % Corresponding file name given $model_name
  % *** should add if statement for 'ncep_doe'
  if nargin==4 && strcmp(model_name,'ncep_doe')
    path_obs = [datapath_obs,'udel_',var_short,'_1979-1999_', ...
                num2str(Nlon), 'x', num2str(Nlat),'.cdf'];
  else
    path_obs = [datapath_obs,'udel_',var_short,'_1969-1999_', ...
                num2str(Nlon), 'x', num2str(Nlat),'.cdf'];
  end

% ----------------------------------------------------------------------

  % Extracting the varible of interest 
  % As of (03/21), the var name in the NetCDF file is 'air'
  disp(['$$$ Extracting ... U. Del. ', var]);
  
  if exist(path_obs);     
    X = nc_varget(path_obs,var_string); 
  else
    disp('ERROR! Path not found')
    return
  end

  % Trimming to summer only and land only
  disp(['$$$ Trimming ... U. Del. ', var]);
  X = summer_only(X,6,8,Nyear);
  X = xmonth(x2d(Iland)).*X;    

%  % Compute climatology and anomalies (maybe ... maybe not)
%  disp(['$$$ Computing ... ', 'var']);
%  if strcmp(opt_anom_Var,'Var')
%    [Tobbar,TobTob,Var_Tob] = anomaly(Tob,opt_anom_Var);
%  else
%    [Tobbar,TobTob,sig_Tob] = anomaly(Tob,opt_anom_Var);
%  end

  % As of (03/21), convert X and Xbar to Kelvin 
  if strcmp(var,'T')
    X = X+273.15;
  end

  % (As of 03/22) Converting to mm/s from cm/month
  if strcmp(var,'P')
    secinday = 60*60*24;
    deltat = [30,31,31];    % # of days in each summer month
    fact = 10./(secinday*repmat(deltat',[Nyear,Nlat,Nlon]));   
    X = fact.*X;
  end

  % ----------------------------------------------------------------------

  %% Note that `X' has missing values (NaNs) in it. (unlike the GCM's)
  %% Anomaly uses nanmean to compute all field.
  %% However, still some grid point have no entries throughout the
  %% sample. This is not a big issue though ...


  L1 = length(find(isnan(X)));
  L2 = Ntime*Nlat*Nlon-Ntime*Nland;
  disp([' # Grid points w/o any entries in obs. data set: ', ...
            num2str((L1-L2)/Ntime)]);

end
