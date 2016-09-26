% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% tm_param.m 
%
% Computing toy model parameterizations.
% ======================================================================

%% Parameterize E' --> using param_evapo.m
%
[e_m,e_F,E00E00,lambda,tau_E] = param_evapo(EE,mm,F0F0,mbar,Fbar); 
% ======================================================================

%% Parameterize H' --> using param_damp.m
%
[kappa,mu,H0H0,H00H00,tau_H] = param_damp(HH,TT,mm); 
% ======================================================================

%% Parameterize R' as (see bld_m_R.m)
%
% R' = r * P'  , [r]={}.
% ----------------------------------------------------------------------
%
disp('Computing ... r');
[r,R0R0] = regrs(RR,PP);					
% ======================================================================

%% Parameterize xiU' as (see bld_T_xiU.m & bld_T_OmegaU.m)
% 
% xiU' = gam_T * T'  , [gam_T]=W/K/m^2
% ----------------------------------------------------------------------
%
disp('Computing ... gam_T');
[gam_T,xiU0xiU0] = regrs(xiUxiU,TT); 
% ======================================================================

%% Parameterize xim' --> using param_xim.m
%
[a,b,xim0xim0,xim00xim00,tau_s] = param_smres(ximxim,mm,PP,e_m.*Fbar);
% ======================================================================
