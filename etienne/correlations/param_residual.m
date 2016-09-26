%%% Evaluate the behavior of the E' and H' param. residuals
  % E_00' and H_00' in absolute terms.
  %
  % see scales/param_residual.m for relative scalings
  % and balances/param_residual.m for absolute scalings (in W/m^2)
  %
  % Make use of the param_evapo.m and param_damp.m
  %
  % Overlaps with ./residual_bias.m.
  % as of 03/11, use this procedure which includes the updated 
  % parameterization algorithms.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%{
U = getnewvar('Uas',opt_anom_Var);
name='tmp';
cvec = [0:1:6]; color_handle = [];
bins = [-1:0.1:30]; yval = 0.2;
Z = U;
plot_summeravg;
break
%}

% Plotting options for all plots ...
opt_monthly = 0;
opt_corlag = 0;
% ======================================================================

% get the parameterization residual
if ~exist('E00E00')
  [junk1,junk2,E00E00] = param_evapo(EE,mm,F0F0,mbar,Fbar); end
if ~exist('H00H00')
  [junk1,junk2,H0H0,H00H00] = param_damp(HH,TT,mm); end
if ~exist('H00skH00sk')
  [junk1,junk2,TskTsk,Var_Tsk] = getnewvar('ts',opt_anom_Var);
  [kappa_sk,mu_sk,H0skH0sk,H00skH00sk,tau_H_sk] ...
                                   = param_damp(HH,TskTsk,mm); end

% combined residual (consistent with notation in correlations/)
OmegaUOmegaU = L*E00E00 + H00H00;

% compute corresp. std's
sig_E00 = anomaly_sig(E00E00);
sig_H00 = anomaly_sig(H00H00);
sig_OmegaU = anomaly_sig(OmegaUOmegaU);

% get wind speed (only in hadgem1) --- labeled as V (U is for sfc engy)
if strcmp(model_name,'hadgem1') && ~exist('VV')
  [junk1,junk2,VV,sig_V] = getnewvar('Uas',opt_anom_Var); end
% ======================================================================

%% Compare correlations of H0H0 and H0H0_sk 
sig_H0 = anomaly_sig(H0H0);
sig_H0sk = anomaly_sig(H0skH0sk);
var_dep = {'m'};
vars_ind = {'H0','H0sk'};
corr_depind; corr_depind_plot
% ======================================================================

break

%% E00
var_dep = 'E00';
%vars_ind = {'T','m','mb','P'};        
vars_ind = {'V'};
corr_depind; corr_depind_plot
% ======================================================================

%% H00
var_dep = 'H00';
%vars_ind = {'T','F0','P'};
corr_depind; corr_depind_plot
% ======================================================================

%% OmegaU
var_dep = {'OmegaU'};
%vars_ind = {'T','m','mb','F0','P'};
corr_depind; corr_depind_plot
% ======================================================================
