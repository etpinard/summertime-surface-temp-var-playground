%%% Scales analysis of RHS term of the surface energy budget
	% 
	% What's with the LHS ... we'll see.
	%
	% We also try to measure the importance of the budget residual 
	%	(storage + T advection?) in comparison to the other terms.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%%% Plotting options for all
opt_monthly = 0;
cvec = [0:0.25:4]; color_handle = @color_ltone;
bins = [0:0.01:4.5]; yval = 3.5;	
% ======================================================================

% Use the latent heat flux (L*E) instead of simply E for better
% comparisons in the same uints of Wm-2
if strcmp(opt_anom_Var,'Var')
	Var_LE = L^2*Var_E;
else
	sig_LE = L*sig_E;
end
% ======================================================================

% The residual of the RHS, the sign is arbitrary and insignificant
% for the following scalings.
xiUxiU = FF-L*EE-HH;
if strcmp(opt_anom_Var,'Var')
	Var_xiU = anomaly_Var(xiUxiU);
else
	sig_xiU = anomaly_sig(xiUxiU);
end
% ======================================================================

% Variables to pair up, vars_pairs

if strcmp(opt_anom_Var,'Var')
	vars_pairs = {'Var_F','Var_LE','Var_H','Var_xiU'};
else
	vars_pairs = {'sig_F','sig_LE','sig_H','sig_xiU'};
end

%%% Call compare.m for computations and compare_plot.m for plotting
compare
compare_plot
	% maybe you should play around with strcmp(opt_anom_var,'Var')
% ======================================================================

break

%%% Is E' that small? Use compare_min to find out

	% first term by term pointwise minimum
if strcmp(opt_anom_Var,'Var')
	var_small = {'Var_LE'};
	vars_big = {'Var_F','Var_H'};	% I should do something about dU'/dt
else
	var_small = {'sig_LE'};
	vars_big = {'sig_F','sig_H'};	% I should do something about dU'/dt
end

compare_min
compare_min_plot
% ======================================================================
