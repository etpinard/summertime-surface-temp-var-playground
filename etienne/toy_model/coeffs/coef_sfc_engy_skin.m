% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% coef_sfc_engy_skin.m
%
% T(skin) version of coef_sfc_engy.m
% 
% ======================================================================

% Get skin parameters
tm_param_skin;
% ======================================================================

% Use the specific heat capacity of the whole troposphere
C_p = 1e5; 

% Param xiU0'_sk
if ~exist('gam_P')
  gam_P_sk = regrs(xiU0xiU0_sk,PP); end       % find a better notation
% ======================================================================


% [unitless] fraction of xiU_0'_sk explained by P'
Z = gam_P_sk/L;
mystats(Z);
cvec = [-0.4:0.2:1.4]; color_handle = [];
bins = [-2:0.01:2]; yval = 4;
name = 'gam_P_sk-L';
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] temperature damping time scale (C_p/kappa_sk)
Z = C_p./kappa_sk/secinday;	
mystats(Z);
cvec = [0:0.1:0.6]; color_handle = [];
bins = [-2:0.1:5]; yval = 5;
name = '1e5_kappa_sk';
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] temperature diffusion/melting time scale (C_p/gam_T_sk)
Z = C_p./gam_T_sk/secinday;	
mystats(Z);
cvec = [0:1:6]; color_handle = [];
bins = [-2:0.1:10]; yval = 1;
name = '1e5_gam_T_sk';
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] soil moisture damping time scale
Z = tau_H_sk/secinday;		
mystats(Z);
cvec = [0:5:35]; color_handle = [];
bins = [0:1:100]; yval = 0.1;
name = 'tau_H_sk';
plot_summeravg; 
% ----------------------------------------------------------------------
