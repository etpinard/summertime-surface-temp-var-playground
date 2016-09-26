% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% get_obs_T_winter.m
%
% Get winter tas observation data from the NetCDF files.
% as well as winter GCM tas.
%
% ======================================================================

% Datapath for the observations
datapath_obs = '/home/disk/p/etienne/nobackup/data/obs/';

% Corresponding file name given $model_name
path_obs = [datapath_obs,'udel_tas_1969-1999_', ...
            num2str(Nlon), 'x', num2str(Nlat),'.cdf'];
% ----------------------------------------------------------------------

% Extracting the varible of interest 
% As of (03/21), the var name in the NetCDF file is 'air'
disp(['$$$ Extracting ... ', 'Tobw']);
Tobw = nc_varget(path_obs,'air');	

% Trimming to winter (months [-1:1]) only and land only
disp(['$$$ Trimming ... ', 'Tobw']);
Tobw = summer_only(Tobw,-1,1,Nyear);
Tobw = xmonth(x2d(Iland)).*Tobw;		

% Compute climatology and anomalies
disp(['$$$ Computing ... ', 'Tobw']);
if strcmp(opt_anom_Var,'Var')
  [Tobwbar,TobwTobw,Var_Tobw] = anomaly(Tobw,opt_anom_Var);
else
  [Tobwbar,TobwTobw,sig_Tobw] = anomaly(Tobw,opt_anom_Var);
end

% As of (03/21), convert Tobw and Tobwbar to Kelvin 
Tobw = Tobw+273.15;
Tobwbar = Tobwbar + 273.15;
% ----------------------------------------------------------------------

% and GCM winter tas 
months_only = [-1,1];
if strcmp(opt_anom_Var,'Var')
  [Tw,Twbar,TwTw,Var_Tw] = getnewvar('tas',opt_anom_Var,months_only);
else
  [Tw,Twbar,TwTw,sig_Tw] = getnewvar('tas',opt_anom_Var,months_only);
end
% ----------------------------------------------------------------------
