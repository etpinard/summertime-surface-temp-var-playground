% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% get_obs_T.m
%
% Get summer tas observation data from the NetCDF files.
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
path_obs = [datapath_obs,'udel_tas_', ...
            num2str(year_start),'-',num2str(year_end),'_' ...
            num2str(Nlon), 'x', num2str(Nlat),'.cdf'];
% ----------------------------------------------------------------------

% Extracting the varible of interest 
% As of (03/21), the var name in the NetCDF file is 'air'
disp(['$$$ Extracting ... ', 'Tob']);
Tob = nc_varget(path_obs,'air');	

% Trimming to summer only 
disp(['$$$ Trimming ... ', 'Tob ']);
Tob = summer_only(Tob,only_m1,only_m2,Nyear);

% Trimming to land only 
Ntime = size(Tob,1);
Tob = x2d(Iland,Ntime).*Tob;

if ~opt_no_anom

  % Compute climatology and anomalies
  disp(['$$$ Computing ... ', 'Tob']);
  if strcmp(opt_anom_Var,'Var')
    [Tobbar,TobTob,Var_Tob] = anomaly(Tob,opt_anom_Var);
  else
    [Tobbar,TobTob,sig_Tob] = anomaly(Tob,opt_anom_Var);
  end

end

% As of (03/21), convert Tob and Tobbar to Kelvin 
Tob = Tob + 273.15;

if exist('Tobbar')
  Tobbar = Tobbar + 273.15; end
% ----------------------------------------------------------------------

%% Note that `Tob' has missing values (NaNs) in it. (unlike the GCM's)
%% Anomaly uses nanmean to compute all field.
%% However, still some grid point have no entries throughout the
%% sample. This is not a big issue though ...

if ~opt_no_anom
  tmp = length(find(isnan(Tob)));
  tmp2 = Ntime*Nlat*Nlon-Ntime*Nland;
  disp([' # Grid points w/o any entries in obs. data set: ', ...
            num2str((tmp-tmp2)/Ntime)]);
  clear tmp tmp2
end
% ----------------------------------------------------------------------
