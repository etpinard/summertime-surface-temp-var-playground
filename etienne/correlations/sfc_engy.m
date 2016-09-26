%%% Correlations of the variables included is the 
	% surface energy budget equation.
	% Correlations between T, F, E an H are computed
	% 
	% Uses corr_pairs.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Selecting the variables to pair up, vars_pairs
vars_pairs = {'T','F','F0','E','H','xiU'};
% ======================================================================

%%% Call corr_pairs.m for computations
opt_corlag = 1;
corr_pairs
% ======================================================================

%%% Call corr_depind_plot.m for plotting
opt_monthly = 0;
corr_pairs_plot
% ======================================================================
