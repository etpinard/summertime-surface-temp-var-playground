% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% state_means.m
%
% Computes and plots the annual cycle range for the mean state variables 
% Tbar and mbar.
% ======================================================================


% plotting options
opt_overlay = 0;
opt_x_cvec = 'add_both';
cvec = [-4:1:4]; color_handle = @color_myjet;
bins = [-10:0.2:10]; yval = 1;
% ----------------------------------------------------------------------

% GCM Tbar
name = 'season-cycle_Tbar';
Z = ssn_rg(Tbar);
mystats(Z,'GCM Tbar ssn_rg [K]')
plot_summeravg;

% Obs. Tbar
name = 'season-cycle_obs_Tbar';
Z = ssn_rg(obs_Tbar);
mystats(Z,'Obs. Tbar ssn_rg [K]')
plot_summeravg;

% ----------------------------------------------------------------------

% GCM mbar
cvec = [-4:1:4]; 
bins = [-10:0.2:10]; yval = 1;

name = 'season-cycle_mbar';
Z = ssn_rg(mbar);
mystats(Z,'GCM mbar ssn_rg [mm]')
plot_summeravg;
% ======================================================================
