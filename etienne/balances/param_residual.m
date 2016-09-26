%%% Compares the magnitudes of the E' and H' param. residuals
  % E_00' and H_00' in absolute terms. *** Should this be in
  % distributions2/ instead ?
  %
  % see scales/param_residual.m for relative scalings
  %
  % Make use of the param_evapo.m and param_damp.m
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% get the parameterization residual
if ~exist('E00E00')
  [junk1,junk2,E00E00] = param_evapo(EE,mm,F0F0,mbar,Fbar); end
if ~exist('H00H00')
  [junk1,junk2,junk3,H00H00] = param_damp(HH,TT,mm); end

% compute magnitudes ...
sig_LE00 = L*anomaly_sig(E00E00);
sig_H00 = anomaly_sig(H00H00);
OmegaU = L*E00E00 + H00H00;
sig_OmegaU = anomaly_sig(OmegaU);
% ======================================================================


%%% plotting (all in W/m^2)
cvec = [0:3:21]; color_handle = [];
bins = [-1:0.1:30]; yval = 0.2;

name = 'Lsig_E00';  
Z = sig_LE00;
mystats(Z); 
plot_summeravg; %plot_all;

name = 'sig_H00';
Z = sig_H00;
mystats(Z); 
plot_summeravg; %plot_all;

name = 'sig_OmegaU';
Z = sig_OmegaU;
mystats(Z); 
plot_summeravg; %plot_all;
% ======================================================================
