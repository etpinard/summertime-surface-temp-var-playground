%%% Investigating correlations between surface temperature and soil
	% moisture. To what level are to budget coupled?
	%
	% Now, also investigating and comparing the skin temperature
	% coupling.
	%
	% Uses corr_depind.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% T with soil moisture budget variables
var_dep = 'T';			
%vars_ind = {'m','mb','E','xim'};
vars_ind = {'m','E'};

opt_corlag = 0;
opt_monthly = 0;
corr_depind
corr_depind_plot
% ======================================================================

break

%% specific humidity with soil moisture budget variables

% get wind speed (only in hadgem1) --- labeled as V (U is for sfc engy)
if strcmp(model_name,'ccsm3') && ~exist('qq')
  [junk1,junk2,qq,sig_q] = getnewvar('huss',opt_anom_Var); end

var_dep = 'q';			
vars_ind = {'m','xim'};

opt_corlag = 0;
opt_monthly = 0;
corr_depind
corr_depind_plot
% ======================================================================


%% evaporative fraction with soil moisture budget variables

% compute L*E/F anomaly and std
[junk,EFEF,sig_EF] = anomaly(L*E./F,opt_anom_Var);

var_dep = 'EF';			
vars_ind = {'m','q'};

opt_corlag = 0;
opt_monthly = 0;
corr_depind
corr_depind_plot
% ======================================================================



break

%%% Repeat with the skin temperature
if ~exist('TskTsk')
	[junk1,junk2,TskTsk,sig_Tsk] = getnewvar('ts',opt_anom_Var);
end

var_dep = 'Tsk';		% same vars_ind
corr_depind
corr_depind_plot
% ======================================================================

%%% And correlation between skin and surface air temperature
vars_pairs = {'T','Tsk'};
corr_pairs
corr_pairs_plot
% ======================================================================
