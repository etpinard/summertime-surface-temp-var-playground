%%% Seeking the best parameterization for R, the runoff term.
	% Regression with m and P are computed
	% Relative magnitudes of the residuals are compared.
	% 
	% Uses regrs_single.m for computation.
	%
	%	NOTE: Need to figure out if mrros (i.e. R) is enough to
	%	characterize "soil moisture transport" or if we need to add an
	% inflitration term to the soil moisture budget.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Selecting the variable to be regressed, var_before
var_before = 'R';		% a string

% Selecting the regressor variables, vars_after
vars_after = {'m','P'};
Nvar_after = length(vars_after);
% ======================================================================

%%% Call regrs_single.m for computations
regrs_single
% ======================================================================

%%% Call regrs_single_plot.m for plotting

opt_monthly = 0;
%cvec = [0:0.2:4]; color_handle = @color_ltone;
%bins = [0:0.1:5]; yval = 1.5;

cvec = [0:0.1:1]; color_handle = [];	% i.e. stick with jet
bins = [0:0.05:1.5]; yval = 2.5;

regrs_single_plot
% ======================================================================
