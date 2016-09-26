%%% Investigating different parameterization for xi_U' the anomaly
  % surface energy residual. 
  %
  % We have 
  % 
  % 0 = F - L*E - H - xi_U 
  %
  % Define xi_Ubar = Fbar - L*Ebar - Hbar and therefore
  %
  % 0 = F' - L*E' - H' - xi_U' exactly.
  %
  % Now try to parameterize xi_U' using projections as best as we can.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Plotting options for all plots
cvec = [-1:0.5:8]; color_handle = [];
bins = [-1:0.1:10]; yval = 1;

% Define xiU'
xiUxiU = FF - L*EE - HH;

% Choose which variables to project onto
vars_ind = {'F','F0','T','H','P','m','E'};
% ======================================================================


for i=1:length(vars_ind)

  % assign var_ind(i) to X
  eval(['XX = ' char(vars_ind(i)) char(vars_ind(i)) ';']);

  % project xiUxiU onto XX
  gamma = regrs(xiUxiU,XX);
  
  % compute new residual and its variance.
  tmp = xiUxiU - xmonth(gamma).*XX;
  check_xiU = anomaly_Var(tmp);

  % output and plotting
  name = ['param_xiU-' char(vars_ind(i))];
  Z = sqrt(check_xiU);                        % in W/m^2
  mystats(Z); 
  plot_summeravg; %plot_all;

end

% ======================================================================
