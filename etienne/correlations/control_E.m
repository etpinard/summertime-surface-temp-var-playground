%%% Investigating the "evaporation control" regimes.
	% Correlations between E, P, F and F0 are computed
	% Relative magnitudes of the covariance terms are compared.
	% 
	% Uses corr_pairs.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Selecting the variables to pair up, vars_pairs
vars_pairs = {'E','P','F','F0'};
Nvar_pairs = length(vars_pairs);
% ======================================================================

%%% Call corr_pairs.m for computations
opt_corlag = 0;		% no lagged correlations
corr_pairs
% ======================================================================

%%% Call corr_depind_plot.m for plotting
opt_monthly = 0;
opt_overlay = 0;		
corr_pairs_plot
% ======================================================================
