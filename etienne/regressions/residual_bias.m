%%% Investigation whether the regression residuals (E_00', H_00' and
	% R_0') are bias with respect to their original variables.
	%
	% NO, it will never be case by virtue of (linearly) projecting the 
	%	anomalies! A very lovely results actually. X' is never
	%	systematically over or under estimated by this projections method.
	%
	% This procedure is useless. (see correlations/residual_bias.m)
	% 
	%	See e.g. evapo{,_multiple}.m for more info on their regressions
	%	(i.e.  projections) used.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%%% 1a) E_00'  (with m' first then F_0')

if ~exist('err_E_mF0')
	
		% first compute e_m and e_F
	[em,E0E0] = regrs(EE,mm);
	[eF,junk] = regrs(E0E0,F0F0);
	clear E0E0 junk
	
		% define the error (two-sided)
	err_E_mF0 = (EE - (xmonth(em).*mm + xmonth(eF).*F0F0))./ ...
																					xmonth(sqrt(Var_E));

end

	% Worldwide stats
mystats(err_E_mF0);

	% plot the maximum in time at every grid box
Z = sqmean(err_E_mF0);
name = 'err_E_mF0-mean';
cvec = [-0.01:0.001:0.01]; color_handle = @color_corr3;
bins = [-0.01:0.0001:0.01]; yval = 3;
plot_summeravg

Z = sqz(nanvar(err_E_mF0));
name = 'err_E_mF0-Var';
cvec = [0:0.1:2]; color_handle = [];
bins = [0:0.01:2]; yval = 3;
plot_summeravg
% ======================================================================




