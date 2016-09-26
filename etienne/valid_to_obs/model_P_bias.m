% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% model_P_bias.m
%
% Compute the relative bias (bias.m) of the $model_name Var(P) the
% the observed Var(P). The precip flux [mm/s] is used throughout.
%
% ======================================================================

%% get P obs 
if ~exist('Pob') 
  get_obs_P;  end
% ----------------------------------------------------------------------

%% 1) relative bias on Var(P)
name = 'obs_bias_Var_P';

%% compute relative bias
Z = bias(Var_P,makenan(Var_Pob,'==0'));

%% output some statistics
mystats(Z,['Relative bias of the ' model_name ' Var(P) in summer']);

%% plot using plot_summeravg.m (or plot_all.m)
cvec = [-1:0.25:3]; color_handle = @color_posbias;
bins = [-0.9:0.1:5]; yval = 3.5;
opt_overlay = 0;

plot_summeravg;
%plot_all;
% ----------------------------------------------------------------------

%% 2) bias (or difference) on Pbar [in mm/day]
name = 'obs_diff_Pbar';

%% compute bias
Z = (Pbar-Pobbar)*secinday;

%% output some statistics
mystats(Z,['Bias of the ' model_name ' Pbar in summer [in mm/day]']);

%% plot using plot_summeravg.m (or plot_all.m)
cvec = [-2:0.5:2]; color_handle = @color_myjet;
bins = [-5:0.1:5]; yval = 1;
opt_overlay = 0;

plot_summeravg;
%plot_all;
% ----------------------------------------------------------------------
