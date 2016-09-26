%%% Same as damping.m but now using regrs_multiple.m
	% 
	%	 Now including the skin temperature.
	%
	%	Note that
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

% Extracting the skin temperature 
if ~exist('TskTsk')
	if strcmp(opt_anom_Var,'Var')
		[junk1,junk2,TskTsk,Var_Tsk] = getnewvar('ts',opt_anom_Var);
	else
		[junk1,junk2,TskTsk,sig_Tsk] = getnewvar('ts',opt_anom_Var);
	end
end

% Selecting the variable to be regressed, var_before
var_before = 'H';		% a string

% Selecting the regressor variables, vars_after
vars_after = {'T','Tsk','m'};				
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
