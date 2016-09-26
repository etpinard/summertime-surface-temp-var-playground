%%% Compares the magnitudes of the E' and H' param. residuals
  % E_00' and H_00'.
  %
  % Make use of the param_evapo.m and param_damp.m
  % Coded from opt_anom_Var='no'
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% plotting option for all plots
opt_monthly = 0;
cvec = [0:0.25:4]; color_handle = @color_ltone;
bins = [0:0.01:4.5]; yval = 3.5;	
% ======================================================================

% get the parameterization residual
if ~exist('E00E00')
  [junk1,junk2,E00E00] = param_evapo(EE,mm,F0F0,mbar,Fbar); end
if ~exist('H00H00')
  [junk1,junk2,junk3,H00H00] = param_damp(HH,TT,mm); end
% ======================================================================


%%% Compare sig_H00 and L * sig_E00 with each other and sig_F

sig_LE00 = L*anomaly_sig(E00E00);
sig_H00 = anomaly_sig(H00H00);

% call compare and compare_plot
vars_pairs = {'sig_LE00','sig_H00','sig_F'};
compare
compare_plot
% ======================================================================

%%% Compare OmegaU to sig_F

OmegaU = L*E00E00 + H00H00;
sig_OmegaU = anomaly_sig(OmegaU);

% call compare and compare_plot
vars_pairs = {'sig_OmegaU','sig_F'};
compare
compare_plot
% ======================================================================
