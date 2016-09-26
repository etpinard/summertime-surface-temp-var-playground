% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% model_T_bias.m
%
% Compute the relative bias (bias.m) of the $model_name Var(T) the
% the observed Var(T). The surface temperature is used throughout.
%
% ======================================================================


%% 1) relative bias on Var(T)
name = 'obs_bias_Var_T';

%% compute relative bias
Z = bias(Var_T,Var_Tob);

%% output some statistics
mystats(Z,['Relative bias of the ' model_name ' Var(T) in summer']);

%% plot using plot_summeravg.m (or plot_all.m)
cvec = [-1:0.25:3]; color_handle = @color_posbias2;
bins = [-0.9:0.1:5]; yval = 3.5;
opt_overlay = 0;

%plot_summeravg;
%plot_all;
% ----------------------------------------------------------------------

%% 2) bias (or difference) on Tbar [in K]
name = 'obs_diff_Tbar';

%% compute bias
Z = (Tbar-Tobbar);

%% output some statistics
mystats(Z,['Bias of the ' model_name ' Tbar in summer [in K]']);

%% plot using plot_summeravg.m (or plot_all.m)
cvec = [-4:1:4]; color_handle = @color_myjet;
bins = [-5:0.1:5]; yval = 1;
opt_overlay = 0;

plot_summeravg;
%plot_all;
% ----------------------------------------------------------------------
