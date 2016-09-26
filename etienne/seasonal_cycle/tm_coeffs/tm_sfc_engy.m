% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% coef_sfc_engy.m
%
% Seasonal cycle ranges of the surface energy budget coefficients.
%
% ======================================================================

% Use the specific heat capacity of the whole troposphere
C_p = 1e5; 

% get coefficients
if ~exist('kappa') || ~exist('tau_H')
  [kappa,j1,j2,j3,tau_H] = param_damp(HH,TT,mm); end

if ~exist('lambda') || ~exist('tau_E')
 [j1,j2,j3,lambda,tau_E] = param_evapo(EE,mm,F0F0,mbar,Fbar); end

% missing gam_T

% plotting options for all
opt_overlay = 0;
opt_x_cvec = 'add_both';
color_handle = @color_myjet;
% ----------------------------------------------------------------------

% [unitless] fraction of F' explained by P'
Z = ssn_rg(alpha/L);
mystats(Z);
cvec = [-0.5:0.25:0.5]; 
bins = [-2:0.01:2]; yval = 4;
name = 'ssn-rg_alpha-L';
plot_summeravg; 
% ----------------------------------------------------------------------

% [untiless] efficiency of F_0' to induce evapotransipiration
Z = ssn_rg(lambda);
mystats(Z);
cvec = [-0.3:0.1:0.3]; 
bins = [-2:0.01:2]; yval = 4;
name = 'ssn-rg_lambda';
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] temperature damping time scale (C_p/kappa)
Z = ssn_rg(C_p./kappa/secinday);	
mystats(Z);
cvec = [-0.3:0.1:0.3]; 
bins = [-2:0.1:2]; yval = 5;
name = 'ssn-rg_1e5_kappa';
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] soil moisture evapotranspiration time scale 
Z = ssn_rg(tau_E/secinday);	
mystats(Z);
cvec = [-10:2.5:10];
bins = [-20:1:20]; yval = 0.1;
name = 'ssn-rg_tau_E';
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] soil moisture damping time scale
Z = ssn_rg(tau_H/secinday);
mystats(Z);
cvec = [-10:2.5:10];
bins = [-50:1:50]; yval = 0.1;
name = 'ssn-rg_tau_H';
plot_summeravg; 
% ----------------------------------------------------------------------

break
% [days] temperature diffusion/melting time scale (C_p/gam_T)
Z = ssn_rg(C_p./gam_T/secinday);
mystats(Z);
cvec = [0:1:6]; color_handle = [];
bins = [-2:0.1:10]; yval = 1;
name = 'ssn-rg_1e5_gam_T';
plot_summeravg; 
% ----------------------------------------------------------------------
