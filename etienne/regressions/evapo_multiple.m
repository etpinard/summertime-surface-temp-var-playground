%%% Same as evapo.m but now using regrs_multiple.m
	%
	%	Note that
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Selecting the variable to be regressed, var_before
var_before = 'E';		% a string

% Selecting the regressor variables, vars_after
%vars_after = {'m','F','F0','T'};			% no T ...
vars_after = {'m','mb','F0','P'};			
% ======================================================================

%%% Call regrs_multiple.m for computations
regrs_multiple
% ======================================================================

%%% Call regrs_multiple_plot.m for plotting

opt_monthly = 0;
%cvec = [0:0.2:4]; color_handle = @color_ltone;
%bins = [0:0.1:5]; yval = 1.5;

cvec = [0:0.1:1]; color_handle = [];
bins = [0:0.05:1.5]; yval = 2.5;

regrs_multiple_plot
% ======================================================================
