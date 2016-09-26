% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% model_T_bias_strung.m
%
% Same as model_T_bias.m but now using a strung together data set.
%
% ======================================================================

%% string both TT and TobTob and compute resp. Var(T)'s
if ~exist('Var_T_stg')

if ~exist('Var_Tob_stg')
% ----------------------------------------------------------------------
  

%%% to do !!! (03/27)

%% relative bias on the de-trended Var(T)
name = 'obs_bias_Var_T_dtr';

%% compute relative bias
Z = bias(Var_T_dtr,Var_Tob_dtr);

%% output some statistics
mystats(Z,['Relative bias of the ' model_name ' Var(T) in summer', ...
           ' with trend removed']);

%% plot using plot_summeravg.m (or plot_all.m)
cvec = [-1:0.25:3]; color_handle = @color_posbias;
bins = [-0.9:0.1:5]; yval = 3.5;
opt_overlay = 0;

plot_summeravg;
%plot_all;
% ----------------------------------------------------------------------
