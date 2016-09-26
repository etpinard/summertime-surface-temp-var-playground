% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% get_obs_P.m
%
% Get summer P observation data from the NetCDF files.
%
% ======================================================================
%
% Optional variables:
%
% only_m1, only_m2, (first and last month in sample, `summer_only.m')
% *** by defauly only_m1=6, only_m2=8
%
% opt_no_anom (=1 to not call `anomaly.m')
%
% ======================================================================

% Set the default variables
if ~exist('only_m1') || ~exist('only_m2')
  only_m1 = 6;
  only_m2 = 8; end
if ~exist('opt_no_anom')
  opt_no_anom = 0; end
% ----------------------------------------------------------------------

% Datapath for the observations
datapath_obs = '/home/disk/p/etienne/nobackup/data/obs/';

% Corresponding file name given $model_name
if strcmp(model_name,'ncep_doe')
  year_start = 1979;
else
  year_start = 1969;
end
year_end = 1999;
path_obs = [datapath_obs,'udel_p_', ...
            num2str(year_start),'-',num2str(year_end),'_' ...
            num2str(Nlon), 'x', num2str(Nlat),'.cdf'];
% ----------------------------------------------------------------------

% Extracting the varible of interest 
% As of (03/21), the var name in the NetCDF file is 'precip'
disp(['$$$ Extracting ... ', 'Pob']);
Pob = nc_varget(path_obs,'precip');	

% Trimming to summer only and land only
disp(['$$$ Trimming ... ', 'Pob ']);
Pob = summer_only(Pob,only_m1,only_m2,Nyear);

% Trimming to land only 
Ntime = size(Pob,1);
Pob = x2d(Iland,Ntime).*Pob;

% (As of 03/22) Converting to mm/s from cm/month
disp(['$$$ Converting to mm/s ', 'Pob']);
switch Ntime  % # of days in each summer month
  case 60; deltat = [30,31,31];    
  case 90; deltat = [30,31,31];    
  case 150; deltat = [31,30,31,31,30];    
end
fact = 10./(secinday*repmat(deltat',[Nyear,Nlat,Nlon]));   
Pob = fact.*Pob;

% Compute climatology and anomalies
if ~opt_no_anom
  disp(['$$$ Computing ... ', 'Pob']);
  if strcmp(opt_anom_Var,'Var')
    [Pobbar,PobPob,Var_Pob] = anomaly(Pob,opt_anom_Var);
  else
    [Pobbar,PobPob,sig_Pob] = anomaly(Pob,opt_anom_Var);
  end
end
% ----------------------------------------------------------------------

%% Note that `Pob' has missing values (NaNs) in it. (unlike the GCM's)
%% Anomaly uses nanmean to compute all field.
%% However, still some grid point have no entries throughout the
%% sample. This is not a big issue though ...

tmp = length(find(isnan(Pob)));
tmp2 = Ntime*Nlat*Nlon-Ntime*Nland;
disp([' # Grid points w/o any entries in obs. data set: ', ...
          num2str((tmp-tmp2)/Ntime)]);
clear tmp tmp2
% ----------------------------------------------------------------------
