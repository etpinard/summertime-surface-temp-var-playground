% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% model_T_bias_winter.m
%
% Same as model_T_bias.m but now for only the winter months.
%
% ======================================================================

%% get winter obs and gcm data
if ~exist('Tw') || ~exist('Tobw')
  get_obs_T_winter;  end
% ----------------------------------------------------------------------

%% 1) relative bias on Var(T)
name = 'obs_bias_Var_T_winter';

%% compute relative bias
Z = bias(Var_Tw,Var_Tobw);

%% output some statistics
mystats(Z,['Relative bias of the ' model_name ' Var(T) in winter']);

%% plot using plot_summeravg.m (or plot_all.m)
cvec = [-1:0.25:3]; color_handle = @color_posbias;
bins = [-0.9:0.1:5]; yval = 3.5;
opt_overlay = 0;

plot_summeravg;
%plot_all;
% ----------------------------------------------------------------------

%% 2) bias (or difference) on Tbar [in K]
name = 'obs_diff_Tbar_winter';

%% compute bias
Z = (Twbar-Tobwbar);

%% output some statistics
mystats(Z,['Bias of the ' model_name ' Tbar in winter [in K]']);

%% plot using plot_summeravg.m (or plot_all.m)
cvec = [-4:1:4]; color_handle = @color_myjet;
bins = [-5:0.1:5]; yval = 1;
opt_overlay = 0;

plot_summeravg;
%plot_all;
% ----------------------------------------------------------------------
