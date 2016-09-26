% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% get_obs_HR_T.m
%
% Get summer tas observation high resolution data from the NetCDF file.
%
% ======================================================================

% Datapath for the observations
datapath_obs = '/home/disk/p/etienne/nobackup/data/obs/';

% Corresponding file name given $model_name
path_obs = [datapath_obs,'udel_tas_1969-1999_', ...
            num2str(720), 'x', num2str(360),'.cdf'];
% ----------------------------------------------------------------------

% Extracting the varible of interest 
% As of (03/21), the var name in the NetCDF file is 'air'
disp(['$$$ Extracting ... ', 'obs_T']);
obs_T = nc_varget(path_obs,'air');	
obs_lat = nc_varget(path_obs,'lat');
obs_lon = nc_varget(path_obs,'lon');

% Trimming to summer only and land only
disp(['$$$ Trimming ... ', 'obs_T ']);
obs_T = summer_only(obs_T,6,8,Nyear);
obs_T = xmonth(x2d(Iland)).*obs_T;		

% Compute climatology and anomalies
disp(['$$$ Computing ... ', 'obs_T']);
if strcmp(opt_anom_Var,'Var')
  [obs_Tbar,junk,Var_obs_T] = anomaly(obs_T,opt_anom_Var);
else
  [obs_Tbar,junk,sig_obs_T] = anomaly(obs_T,opt_anom_Var);
end

% As of (03/21), convert obs_T and obs_Tbar to Kelvin 
obs_T = obs_T+273.15;
obs_Tbar = obs_Tbar + 273.15;
% ----------------------------------------------------------------------

%% Note that `obs_T' has missing values (NaNs) in it. (unlike the GCM's)
%% Anomaly uses nanmean to compute all field.
%% However, still some grid point have no entries throughout the
%% sample. This is not a big issue though ...

tmp = length(find(isnan(obs_T)));
tmp2 = Ntime*Nlat*Nlon-Ntime*Nland;
disp([' # Grid points w/o any entries in obs. data set: ', ...
          num2str((tmp-tmp2)/Ntime)]);
clear tmp tmp2
% ----------------------------------------------------------------------
