%%% How good of an approximation to the evaporative fraction is 
  %
  % L*E/F ~= L*Ebar/Fbar + L*E'/Fbar ?
  %
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% General plotting options
cvec = [0:0.1:0.6]; color_handle = [];
bins = [-0.2:0.01:0.9]; yval = 20;
opt_overlay = 0;
% ----------------------------------------------------------------------

% Define Ef, the evaporative fraction
if ~exist('Ef')
  Ef = L*E./F;
  [Efbar,EfEf,sig_Ef] = anomaly(Ef,opt_anom_Var); end
% ----------------------------------------------------------------------

% compute and plot error on full Ef
tmp = xmonth(L*Ebar./Fbar) + L*EE./xmonth(Fbar);
Z = sqmean(bias(tmp,Ef));
mystats(Z);
name = 'check_evapofrac_full';
plot_summeravg;
% ======================================================================

% compute and plot error on EfEf  (for dry regimes)
tmp = L*sig_E./Fbar;
Z = sqmean(bias(tmp,sig_Ef));
mystats(Z);
name = 'check_evapofrac_anom_dry';
plot_summeravg;
% ======================================================================

% compute and plot error on EfEf (for wet regimes)
tmp = L*anomaly_sig(-xmonth(Ebar./Fbar.^2).*FF);
Z = sqmean(abias(tmp,sig_Ef));
mystats(Z);
name = 'check_evapofrac_anom_wet';
plot_summeravg;
% ======================================================================

% add next order term
tmp = L*anomaly_sig(EE./xmonth(Fbar) - xmonth(Ebar./Fbar.^2).*FF );
%tmp = L*anomaly_sig(EE./xmonth(Fbar) - xmonth(Ebar./Fbar.^2).*FF - ...
%                     EE.*FF./xmonth(Fbar.^2));     % or both
Z = sqmean(bias(tmp,sig_Ef));
mystats(Z);
name = 'check_evapofrac_anom_2terms';
plot_summeravg;
% ======================================================================
