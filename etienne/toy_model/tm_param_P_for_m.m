% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% tm_param_P_for_m.m 
%
% Computing toy model parameterizations using P' instead of m'
%
% Only the H' and E' parameterization are affected:
%
% H' = kappa*T' + L*nu_H*P' 
% E' = nu_E*P' - lambda_P/L*F_0'
% 
% ======================================================================


%% Re-parameterize H' --> using param_damp.m
%
% kappa and H0H0 are left unchanged and tau_H is meaning-less
% ----------------------------------------------------------------------

if ~exist('nu_H')
  [junk,tmp,junk2,H00H00_P] = param_damp(HH,TT,PP); 
  nu_H = tmp/L; end
% ======================================================================

%% Re-parameterize E' as 
%
% tau_E is meaning-less
% ----------------------------------------------------------------------
%
if ~exist('nu_E') || ~exist('lambda_P')
  [tmp,tmp2,EOOEOO_P] = param_evapo(EE,PP,F0F0,mbar,Fbar);
  nu_E = tmp.*Fbar; 
  lambda_P = tmp2.*mbar/L; end
% ======================================================================
