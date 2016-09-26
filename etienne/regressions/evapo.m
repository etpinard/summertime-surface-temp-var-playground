%%% Seeking the best parameterization for E, the evapotranspiration.
	% Regression with m, F, F0 and T are computed
	% Relative magnitudes of the residuals are compared.
	% 
	% Uses regrs_single.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


wet = find(m > m_crit);
mdrymdry = mm;
mdrymdry(wet) = NaN;
if strcmp(opt_anom_Var,'Var')
	Var_mdry = anomaly_Var(mdrymdry);
else
	sig_mdry = anomaly_sig(mdrymdry);
end

dry = find(m < m_crit);
F0wetF0wet = F0F0;
F0wetF0wet(dry) = NaN;
if strcmp(opt_anom_Var,'Var')
	Var_F0wet = anomaly_Var(F0wetF0wet);
else
	sig_F0wet = anomaly_sig(F0wetF0wet);
end
% ======================================================================

% Selecting the variable to be regressed, var_before
var_before = 'E';		% a string

% Selecting the regressor variables, vars_after
%vars_after = {'m','mb','F','F0','T','P'};

% Both of these do not change things much ...
vars_after = {'mdry','F0wet'};
% ======================================================================

%%% Call regrs_single.m for computations
regrs_single
% ======================================================================

%%% Call regrs_single_plot.m for plotting

opt_monthly = 0;
cvec = [0:0.1:1]; color_handle = [];
bins = [0:0.05:1.5]; yval = 2.5;
regrs_single_plot
% ======================================================================
