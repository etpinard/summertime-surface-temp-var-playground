% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% model_T_bias_detrend.m
%
% Same as model_T_bias.m but now using detrended observations and GCM 
% outputs.
%
% ======================================================================

%% detrend T and Tob using dtrnd.m 
if ~exist('Var_T_dtr')
  disp(['$$$ Detrending ... TT']);
  TT_dtr = dtrnd(TT);
  Var_T_dtr = anomaly_Var(TT_dtr); 
  mystats(bias(Var_T,Var_T_dtr),'Bias(Var_T,Var_T_dtr)'); end

if ~exist('Var_Tob_dtr')
  disp(['$$$ Detrending ... TobTob']);
  TobTob_dtr = dtrnd(TobTob);
  Var_Tob_dtr = anomaly_Var(TobTob_dtr);
  mystats(bias(Var_Tob,Var_Tob_dtr),'Bias(Var_Tob,Var_Tob_dtr)'); end
% ----------------------------------------------------------------------
  

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

break
%% this belong elsewhere (in distributions2/)
Z = bias(Var_T,Var_T_dtr);
name = 'tmp';
cvec = [-0.5:0.1:0.5]; color_handle = @color_posbias;
bins = [-1:0.05:2]; yval = 10;
plot_summeravg;

