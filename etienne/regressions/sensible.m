%%% Investigating the relative contribution of both components 
	% of the damping term H to the regressions presented in damping.m
	% and damping_multiple.m
	% 
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% 1) Hs (hfss), the sensible heat flux

% Extract Hs from netCDF file using getnewvar.m
if ~exist('Hs') || ~exist('Hsbar') || ~exist('HsHs')
	if strcmp(opt_anom_Var,'Var')
		[Hs,Hsbar,HsHs,Var_Hs] = getnewvar('hfss',opt_anom_Var);
	else
		[Hs,Hsbar,HsHs,sig_Hs] = getnewvar('hfss',opt_anom_Var);
	end
end
% ======================================================================

% Selecting the variable to be regressed, var_before
var_before = 'Hs';		% a string

% Selecting the regressor variables, vars_after
vars_after = {'m','T'};
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

break

%%% And similarly for regrs_multiple_plot
regrs_multiple
regrs_multiple_plot
% ======================================================================

%% 2) Flu	(rlus), the Plank upward longwave radiation at the surface

% Extract Flw from netCDF file using getnewvar.m
if ~exist('Flu') || ~exist('Flubar') || ~exist('FluFlu')
	if strcmp(opt_anom_Var,'Var')
		[Flu,Flubar,FluFlu,Var_Flu] = getnewvar('rlus',opt_anom_Var);
	else
		[Flu,Flubar,FluFlu,sig_Flu] = getnewvar('rlus',opt_anom_Var);
	end
end
% ======================================================================

% Selecting the variable to be regressed, var_before
var_before = 'Flu';		% a string

% Selecting the regressor variables, vars_after
vars_after = {'m','T'};
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

%%% And similarly for regrs_multiple_plot
regrs_multiple
regrs_multiple_plot
% ======================================================================

clear m_trim 
