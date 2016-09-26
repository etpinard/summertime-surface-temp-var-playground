%%% Investigating different parameterization for xi_m' the anomaly
  % surface energy residual. 
  %
  % We have 
  % 
  % 0 = P - E - R - xi_m 
  %
  % Define xi_mbar = Pbar - Ebar - Rbar and therefore
  %
  % 0 = P' - E' - R' - xi_m' exactly.
  %
  % Now try to parameterize xi_m' using projections as best as we can.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Plotting options for all plots
cvec = [-0.2:0.2:2]; color_handle = [];
bins = [-1:0.05:4]; yval = 1.5;

% Define xim'
%ximxim = PP - 0.5*EE - RR;
ximxim = PP - EE - RR;

% Choose which variables to project onto
vars_ind = {'P','m','E','R','F0','F'};
% ======================================================================


for i=1:length(vars_ind)

  % assign var_ind(i) to X
  eval(['XX = ' char(vars_ind(i)) char(vars_ind(i)) ';']);

  % project ximxim onto XX
  a = regrs(ximxim,XX);
  
  % compute new residual and its variance.
  tmp = ximxim - xmonth(a).*XX;
  check_xim = anomaly_Var(tmp);

  % output and plotting
  name = ['param_xim-' char(vars_ind(i))];
  Z = sqrt(check_xim)*secinday;       % in mm
  mystats(Z); 
  plot_summeravg; %plot_all;

end

% ======================================================================

