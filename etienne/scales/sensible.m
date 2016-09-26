%%% Investigating the relative contribution of both components 
	% of the damping term H to the regressions presented in damping.m
	% and damping_multiple.m
	% 
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% Extracting Hs and Flu from netCDF files

% 1) Hs (hfss), the sensible heat flux

% Extract Hs from netCDF file using getnewvar.m
if ~exist('Hs') || ~exist('Hsbar') || ~exist('HsHs')
	if strcmp(opt_anom_Var,'Var')
		[Hs,Hsbar,HsHs,Var_Hs] = getnewvar('hfss',opt_anom_Var);
	else
		[Hs,Hsbar,HsHs,sig_Hs] = getnewvar('hfss',opt_anom_Var);
	end
end

% 2) Flu (rlus), the Plank upward longwave radiation at the surface

% Extract Flw from netCDF file using getnewvar.m
if ~exist('Flu') || ~exist('Flubar') || ~exist('FluFlu')
	if strcmp(opt_anom_Var,'Var')
		[Flu,Flubar,FluFlu,Var_Flu] = getnewvar('rlus',opt_anom_Var);
	else
		[Flu,Flubar,FluFlu,sig_Flu] = getnewvar('rlus',opt_anom_Var);
	end
end
% ======================================================================

% Variables to pair up, vars_pairs

if strcmp(opt_anom_Var,'Var')
	vars_pairs = {'Var_H','Var_Hs','Var_Flu'};
else
	vars_pairs = {'sig_H','sig_Hs','sig_Flu'};
end

%%% Call compare.m for computations
compare
% ======================================================================

%%% Call compare_plot.m for plotting

opt_monthly = 0;
cvec = [0:0.25:4]; color_handle = @color_ltone;
bins = [0:0.01:4.5]; yval = 3.5;	
	% maybe you should play around with strcmp(opt_anom_var,'Var')

compare_plot
% ======================================================================
