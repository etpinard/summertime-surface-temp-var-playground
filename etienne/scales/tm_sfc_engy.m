% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% tm_sfc_engy.m 
%
% Scale analysis of surface energy budget after H' decomposition. 
% Coded for opt_anom_Var='no'
% 
% ======================================================================

%%% Plotting options for all
opt_monthly = 0;
cvec = [0:0.25:4]; color_handle = @color_ltone;
bins = [0:0.01:4.5]; yval = 3.5;	
% ----------------------------------------------------------------------

% decompose H' = kappa*T' + H_0' 
if ~all(ismember({'kappa','H0H0'},who))
[kappa,junk1,H0H0] = param_damp(HH,TT,mm); end

% planck term
sig_kappaT = kappa.*sig_T;

% latent heat flux
sig_LE = L*sig_E;

% ~sensible heat flux
sig_H0 = anomaly_sig(H0H0);

% (maybe) precip. part of F'
sig_alphaP = alpha.*sig_P;
% ----------------------------------------------------------------------
	
% Call compare.m and compare_plot.m
vars_pairs = {'sig_kappaT','sig_F','sig_LE','sig_H0'};
%vars_pairs = {'sig_kappaT','sig_F0','sig_alphaP','sig_LE','sig_H0'};
compare
compare_plot
% ======================================================================
