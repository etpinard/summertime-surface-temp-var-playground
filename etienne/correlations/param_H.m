%%% Seeking to best parameterization for H, the temperature
	% damping term.
	% 
	% Uses corr_depind.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

% Plotting options for all plots ...
opt_monthly = 0;
opt_corlag = 0;
% ======================================================================

%%% First for H
var_dep = 'H';		% a string

% Selecting the set of possible independent variables, vars_ind
%vars_ind = {'T','m','P','Pc'};
vars_ind = {'V'};
	
% extract Pc from netCDF file using getnewvar.m
if ~exist('PcPc') && isinarray('Pc',vars_ind)
	[junk1,junk2,PcPc,sig_Pc] = getnewvar('prc'); end

% get wind speed (only in hadgem1) --- labeled as V (U is for sfc engy)
if strcmp(model_name,'hadgem1') && ~exist('VV')
  [junk1,junk2,VV,sig_V] = getnewvar('Uas',opt_anom_Var); end
% ======================================================================

%%% Call corr_depind.m and corr_depind_plot.m 
corr_depind
corr_depind_plot
% ======================================================================

%break

%%% Then for H0
var_dep = 'H0';		% a string

% Selecting the set of possible independent variables, vars_ind
%vars_ind = {'m','P','Pc'};

% compute H0H0 using param_damp
if ~exist('H0H0') || ~exist('sig_H0');
  [junk1,junk2,H0H0] = param_damp(HH,TT,mm);
	sig_H0 = anomaly_sig(H0H0); end
	
% extract Pc from netCDF file using getnewvar.m
if ~exist('PcPc') && isinarray('Pc',vars_ind)
	[Pc,Pcbar,PcPc,sig_Pc] = getnewvar('prc'); end
% ======================================================================

%%% Call corr_depind.m and corr_depind_plot.m 
corr_depind
corr_depind_plot
% ======================================================================
