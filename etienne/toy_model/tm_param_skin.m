% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% tm_param_skin.m 
%
% Computing toy model parameterizations for T(skin) analysis.
% All re-computed fields feature a '_sk' suffix.
% ======================================================================

%% Extract Tsk
%
if ~exist('TskTsk')
  [junk1,junk2,TskTsk,Var_Tsk] = getnewvar('ts',opt_anom_Var); end
% ======================================================================

%% Re-parameterize H' --> using param_damp.m
%
if ~exist('kappa_sk')
  [kappa_sk,mu_sk,H0H0_sk,H00H00_sk,tau_H_sk] ...
                                   = param_damp(HH,TskTsk,mm); end
% ======================================================================

%% Re-parameterize xiU' as 
% 
% xiU' = gam_T_sk * Tsk'  , [gam_T_sk]=W/K/m^2
% ----------------------------------------------------------------------
%
if ~exist('gam_T_sk')
  disp('Computing ... gam_T_sk');
  [gam_T_sk,xiU0xiU0_sk] = regrs(xiUxiU,TskTsk); end
% ======================================================================
