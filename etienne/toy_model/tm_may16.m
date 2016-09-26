% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% tm_may16.m 
%
% Toy model of May 16.
%
% Hs' is explicitly included into the toy model equations.
%
% -) Hs' = k_H*T' + L*omega_H*m' (more or less like tm_may15.m).
% 
% ======================================================================

%% if called from another procedure just to get tm_Var_m and tm_Var_T.
if ~exist('opt_plot')
  opt_plot = 1; 
else
  clear kappa_H kappa_lw kappa_D
end
% ----------------------------------------------------------------------

%% (05/20) Flu (and Flubar, FluFlu, Var_Flu) are extracted from startup

%% (05/13) Hs (and Hsbar, HsHs, Var_Hs) are extracted from startup

%% Get new residual, call it D
DD = FF - L*EE - HsHs - FluFlu;

% E' param and all soil moisture params stay the same, relabel
omega_E = e_m.*Fbar;

% param Hs' 
if ~exist('kappa_H')
  [kappa_H,Hs0Hs0] = regrs(HsHs,TT); 
  [tmp,Hs00Hs00] = regrs(Hs0Hs0,-mm); 
  omega_H = tmp/L; end

% param Flu'
if ~exist('kappa_lw')
  [kappa_lw,Flu0Flu0] = regrs(FluFlu,TT); end

% param D'
if ~exist('kappa_D')
  [kappa_D,D0D0] = regrs(DD,TT); end

%% Collect coefficients
beta = r + b;
kappa_new = kappa_lw + kappa_D + kappa_H;
chi_new = (omega_E - omega_H).*tau_s;

%% old coefficients for reference
chi = (e_m.*Fbar-mu/L).*tau_s;
% ----------------------------------------------------------------------


%% New Var(T) !!!

tm_Var_T = 1./(kappa_new).^2.* ...
           ( (1-lambda.*(1-chi_new)).^2.*Var_F0 + ...
           (alpha + L*chi_new.*(1-beta)).^2.*Var_P );

if opt_plot
  Z = tm_Var_T;
  name = 'tm_may16_T';
  plot_tm_bias_T;
  plot_tm_sig_T;
%  plot_tm_sig_T_diff;
end
% ======================================================================

%break

%% Var(m) (unchanged from March 15 version)

tm_Var_m = tau_s.^2.* ...
           ( (1-r-b).^2.*Var_P + (lambda/L).^2.*Var_F0 );

if opt_plot
  Z = tm_Var_m;
  name = 'tm_may16_m';
  plot_tm_bias_m;
  plot_tm_sig_m;
%  plot_tm_sig_T_diff;
end
% ======================================================================
