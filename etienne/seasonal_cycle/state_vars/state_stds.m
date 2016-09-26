% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% state_stds.m
%
% Computes and plots the annual cycle range for the mean state
% variabilities sig_T and sig_m.
% 
% ======================================================================

% plotting options
opt_overlay = 0;
opt_x_cvec = 'add_both';
cvec = [-1.25:0.25:1.25]; color_handle = @color_myjet;
bins = [-5:0.1:5]; yval = 1.5;
% ----------------------------------------------------------------------

% GCM sig_T
name = 'season-cycle_sig_T';
Z = ssn_rg(sig_T);
mystats(Z,'GCM sig_T ssn_rg [K]')
plot_summeravg;

% Obs. sig_T
name = 'season-cycle_obs_sig_T';
Z = ssn_rg(obs_sig_T);
mystats(Z,'Obs. sig_T ssn_rg [K]')
plot_summeravg;
% ----------------------------------------------------------------------

% GCM sig_m
cvec = [-2:0.5:2]; 
bins = [-5:0.1:5]; yval = 1;

name = 'season-cycle_sig_m';
Z = ssn_rg(sig_m);
mystats(Z,'GCM sig_m ssn_rg [mm]')
plot_summeravg;
% ======================================================================
