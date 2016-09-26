%%% Investigates correlations between the surface albedo and the state 
	% variable. That is, is F really fully external to our land-surface
  % system.
	% 
	% Uses corr_depind.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%%% Extracting both shortwave terms and computing the albedo

if ~exist('Fsd')
  Fsd = getnewvar('rsds',opt_anom_Var);
end
if ~exist('Fsu')
  Fsu = getnewvar('rsus',opt_anom_Var);
end

A = Fsu./Fsd;
[junk1,AA,sig_A] = anomaly(A);
% ======================================================================

%%% Call corr_pairs.m for computations
var_dep = 'A';
vars_ind = {'T','m','P'};
opt_corlag = 0;
corr_depind
% ======================================================================

%%% Call corr_pairs_plot.m for plotting
opt_monthly = 0;
corr_depind_plot
% ======================================================================
