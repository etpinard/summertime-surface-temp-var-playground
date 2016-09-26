%%% Scales analysis of RHS term of the soil moisture budget
	% 
	% As with sfc_engy.m : the LHS ... we'll see.
	%
	% We also try to measure the importance of the budget residual 
	%	(infiltration + storage) in comparison to the other terms.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%%% Plotting options for all
opt_monthly = 0;
cvec = [0:0.25:4]; color_handle = @color_ltone;
bins = [0:0.01:4.5]; yval = 3.5;	
% ======================================================================

% Form the moisture budget equation
ximxim = PP-EE-RR;
if strcmp(opt_anom_Var,'Var')
	Var_xim = anomaly_Var(ximxim);
else
	sig_xim = anomaly_sig(ximxim);
end
% ======================================================================

% Variables to pair up, vars_pairs

if strcmp(opt_anom_Var,'Var')
	vars_pairs = {'Var_P','Var_E','Var_R','Var_xim'};
else
	vars_pairs = {'sig_P','sig_E','sig_R','sig_xim'};
end

%%% Call compare.m for computations and compare_plot.m for plotting
compare
compare_plot
	% maybe you should play around with strcmp(opt_anom_var,'Var')
% ======================================================================

break

%%% Is R' that small? Use compare_min to find out

	% first term by term pointwise minimum
if strcmp(opt_anom_Var,'Var')
	var_small = {'Var_R'};
	vars_big = {'Var_P','Var_E'};	% I should do something about dm'/dt
else
	var_small = {'sig_R'};
	vars_big = {'sig_P','sig_E'};	% I should do something about dm'/dt
end

compare_min
compare_min_plot

	% should I plot sig_R / sig_(P-E) as in ccsm_dependences2.pdf ?
% ======================================================================
