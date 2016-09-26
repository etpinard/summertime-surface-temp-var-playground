%%% Startup file for cmip5_and_obs/ 
	%	
  % 1) Load ERA40 data (above all, to get Iland)
	% 2) Load CMIP5 ensemble 'tas_ymonvar.cdf' , 
  %     compute summer Var_T,
  %     trim to land only.
  % 3) Load U. Del observations
% ======================================================================


clear all; 
close all;		

%% Add path to parent directory and set up paths

parent_dir = [fileparts(pwd),'/'];
addpath(parent_dir);
make_paths
% ----------------------------------------------------------------------

%% 1) Load ERA40 data 

model_name = 'era40';
opt_vars_load = 'obs_compare';
opt_anom_Var = 'Var';
[vars_full,vars,Nvar] = startup_vars(opt_vars_load,model_name);	
[trim_opt,m_range] = startup_thres(model_name);		
startup_full

vars_req = {'lon','lat','Iland','T'};
for i=1:length(vars_req)
  var_req = char(vars_req(i));
  cmd=[model_name,'_',var_req,'=',var_req,';'];
  eval(cmd);
end
% ----------------------------------------------------------------------

%% 2) Load CMIP5 ensemble

% do the same for 'Tbar' ...

% get NetCDF
%cmip5_path = [datapath,'cmip5/tas_ymonvar.cdf'];
%cmip5_Var_T = nc_varget(cmip5_path,'tas');        % old 11/10/2013
cmip5_path = [datapath,'cmip5/tas_ymonvar_1member.cdf'];
cmip5_Var_T = nc_varget(cmip5_path,'tas_ymonvar');        
cmip5_lat = nc_varget(cmip5_path,'lat');
cmip5_lon = nc_varget(cmip5_path,'lon');

% Var_T: summer only, as previously JJA in NH and DJF in SH, land only
cmip5_Var_T = summer_only(cmip5_Var_T,6,8,1);
cmip5_Var_T = cmip5_Var_T.*x2d(era40_Iland);

% Output stats
mystats(cmip5_Var_T,'CMIP5 ensemble of Var(T) in summer')

% change 'model_name' to 'cmip5'
model_name = 'cmip5';
save 'global.mat' 'model_name' -append
% ----------------------------------------------------------------------

%% 3) Load U. Del observations

obs_T = getobs('T',Nlat,Nlon);
[obs_Tbar,j1,obs_Var_T] = anomaly(obs_T,opt_anom_Var);
% ----------------------------------------------------------------------
