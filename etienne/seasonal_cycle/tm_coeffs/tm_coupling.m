% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% tm_coupling.m
%
% Seasonal cycle ranges of the land-atmosphere coupling coefficients.
%
% ======================================================================

% Use the specific heat capacity of the whole troposphere
C_p = 1e5; 

% get coefficients
if ~exist('kappa') || ~exist('mu')
  [kappa,mu] = param_damp(HH,TT,mm); end

if ~exist('lambda') || ~exist('e_m')
 [e_m,j2,j3,lambda] = param_evapo(EE,mm,F0F0,mbar,Fbar); end

if ~exist('tau_s') 
  [j1,j2,j3,j4,tau_s] = param_smres(ximxim,mm,PP,e_m.*Fbar); end

%% Chi: the coupling coefficients
chi = (e_m.*Fbar-mu/L).*tau_s;

% plotting options for all
opt_overlay = 0;
opt_x_cvec = 'add_both';
color_handle = @color_myjet;
% ----------------------------------------------------------------------

% [unitless] ratio of m' time scale to the time scale affecting sfc engy
Z = ssn_rg((e_m.*Fbar-mu/L).*tau_s);
mystats(Z);
cvec = [-2:0.5:2]; 
bins = [-3:0.05:3]; yval = 2;
name = 'ssn-rg_chi';
plot_summeravg; 
% ======================================================================
