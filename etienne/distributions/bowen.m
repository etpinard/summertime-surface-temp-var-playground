% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bowen.m
%
% Distributions of the Bowen (=SH/LH).
% 
% ======================================================================

% extract the sensible heat flux
if ~exist('Hs')
  [Hs,Hsbar,HsHs,sig_Hs] = getnewvar('hfss',opt_anom_Var); end
% ----------------------------------------------------------------------

% clim. mean
Z = abs(Hsbar./(L.*Ebar));
mystats(Z,'Bowen clim. mean');
cvec = [0:0.5:3.5]; color_handle = [];
bins = [0:0.05:5]; yval = 1.5;
name = 'bowen_mean';
plot_summeravg; 
% ----------------------------------------------------------------------

% anoms
Z = sig_Hs./(L.*sig_E);
mystats(Z,'Bowen anomalies');
cvec = [0:0.5:3.5]; color_handle = [];
bins = [0:0.05:5]; yval = 1.5;
name = 'bowen_anom';
plot_summeravg; 
% ----------------------------------------------------------------------

%% In general bowen_mean < bowen_anom , except for deserts.
%% For most of the world, Hs' ~ L*E' and the does not follow soil
%% moisture contour lines.

% how do the sensible heat anomalies H_s' compare to the H_0'
% (Not bad at all, consitent with your interpretation).

if ~exist('H0H0')
  [junk1,junk2,H0H0] = param_damp(HH,TT,mm); 
  sig_H0 = anomaly_sig(H0H0); end

Z = bias(sig_H0,sig_Hs);
mystats(Z,'Relative difference sig_H0 to sig_Hs');
cvec = [-0.8:0.1:0.8]; color_handle = @color_myjet;
bins = [-2:0.05:2]; yval = 3.5;
name = 'bias_H0-Hs';
plot_summeravg; 
% ----------------------------------------------------------------------
