% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% coef_sfc_engy.m
%
% Distributions of the surface energy budget coefficients.
% 
% ======================================================================

% Use the specific heat capacity of the whole troposphere
C_p = 1e5; 

% Param xiU0'
if ~exist('gam_P')
  gam_P = regrs(xiU0xiU0,PP); end         % find a better notation
% ======================================================================


% [unitless] fraction of F' explained by P'
Z = alpha/L;
mystats(Z);
cvec = [-0.4:0.2:1.4]; color_handle = [];
bins = [-2:0.01:2]; yval = 4;
name = 'alpha-L';
plot_summeravg; 
% ----------------------------------------------------------------------

% [unitless] fraction of xiU_0' explained by P'
Z = gam_P/L;
mystats(Z);
cvec = [-0.4:0.2:1.4]; color_handle = [];
bins = [-2:0.01:2]; yval = 4;
name = 'gam_P-L';
plot_summeravg; 
% ----------------------------------------------------------------------

% [untiless] efficiency of F_0' to induce evapotransipiration
Z = lambda;		
mystats(Z);
cvec = [-0.2:0.1:1]; color_handle = [];
bins = [-1:0.01:1]; yval = 4;
name = 'lambda';
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] temperature damping time scale (C_p/kappa)
Z = C_p./kappa/secinday;	
mystats(Z);
cvec = [0:0.1:0.6]; color_handle = [];
bins = [-2:0.1:5]; yval = 5;
name = '1e5_kappa';
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] temperature diffusion/melting time scale (C_p/gam_T)
Z = C_p./gam_T/secinday;	
mystats(Z);
cvec = [0:1:6]; color_handle = [];
bins = [-2:0.1:10]; yval = 1;
name = '1e5_gam_T';
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] soil moisture evapotranspiration time scale 
Z = tau_E/secinday;		
mystats(Z);
cvec = [0:5:35]; color_handle = [];
bins = [0:1:100]; yval = 0.1;
name = 'tau_E';
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] soil moisture damping time scale
Z = tau_H/secinday;		
mystats(Z);
cvec = [0:5:35]; color_handle = [];
bins = [0:1:100]; yval = 0.1;
name = 'tau_H';
plot_summeravg; 
% ----------------------------------------------------------------------
