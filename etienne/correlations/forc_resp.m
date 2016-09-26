%%% Investigating correlations between both forcing functions and
	% their respective responses.
	%
	%	02/22 : both forcing functions are obsolete
	%
	% Uses corr_depind.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%%% First gam and T

% Selecting the dependent variable, var_dep
var_dep = 'gam';		
%var_dep = 'F';		% give same answer in this case.

% Selecting the set of possible independent variables, vars_ind
vars_ind = {'T'};
Nvar_ind = length(vars_ind);
% ======================================================================

%% Call corr_depind.m for computations
corr_depind
% ======================================================================

%% Call corr_depind_plot.m for plotting
opt_monthly = 1;
cvec = [-1:0.1:1]; color_handle = @color_corr2;
bins = [-1:0.01:1]; yval = 3;
corr_depind_plot
% ======================================================================


%%% Then psi and m (mb and mf)

% Selecting the dependent variable, var_dep
var_dep = 'psi';		
%var_dep = 'P';		% be careful this makes a difference ...

% Selecting the set of possible independent variables, vars_ind
vars_ind = {'m','mb','mf'};
Nvar_ind = length(vars_ind);
% ======================================================================

%% Call corr_depind.m for computations
corr_depind
% ======================================================================

%% Call corr_depind_plot.m for plotting
opt_monthly = 1;
cvec = [-1:0.1:1]; color_handle = @color_corr2;
bins = [-1:0.01:1]; yval = 3;
corr_depind_plot
% ======================================================================
