% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% tm_may06.m 
%
% Toy model of May 06.
% Var(T) and Var(m) as functions of only Var(F_0) and Var(P).
% 
% ======================================================================

%% if called from another procedure just to get tm_Var_m and tm_Var_T.
if ~exist('opt_plot')
  opt_plot = 1; end

%% extract Planck term
if ~exist('FluFlu')
  [Flu,Flubar,FluFlu,Var_Flu] = getnewvar('rlus',opt_anom_Var); end

%% get new parameters
if ~exist('kappa_new') || ~exist('mu_new')
  [kappa_new,Flu0Flu0] = regrs(FluFlu,TT);
  [mu_new,Hs0Hs0] = regrs(HsHs,-mm); end

%% Chi: the coupling coefficients
chi = (e_m.*Fbar-mu/L).*tau_s;
chi_new = (e_m.*Fbar-mu_new/L).*tau_s;
% ----------------------------------------------------------------------

%% Var(m) (unchanged from March 15 version)

tm_Var_m = tau_s.^2.* ...
           ( (1-r-b).^2.*Var_P + (lambda/L).^2.*Var_F0 );
% ======================================================================


[junk1,Z] = corr_inst(HsHs,FluFlu,sqrt(Var_Hs),sqrt(Var_Flu));
name = 'cor_HsFlu';
mystats(Z);
cvec = [-1:0.1:1];
bins = [-1:0.01:1];
yval = 3;
color_handle = @color_corr4;
%plot_summeravg;

%break

Z = bias(kappa_new,kappa);
name = 'kappa_new-kappa';
mystats(Z);
cvec = [-1:0.1:1];
bins = [-2:0.01:2];
yval = 3;
color_handle = [];
%plot_summeravg;

%break


%% Var(T)

%tm_T = 1./(kappa_gam_T).

tm_Var_T = 1./(kappa_new+gam_T).^2.* ...
           ( (1-lambda.*(1-chi_new)).^2.*Var_F0 + ...
           (alpha + L*chi_new.*(1-r-b)).^2.*Var_P );

%tm_Var_T = 1./(kappa+gam_T).^2.* ...
%           ( (1-lambda.*(1-chi)).^2.*Var_F0 + ...
%           (alpha + L*chi.*(1-r-b)).^2.*Var_P );

if opt_plot
  Z = tm_Var_T;
  name = 'tm_may06_T';
  plot_tm_bias_T;
%  plot_tm_sig_T;
%  plot_tm_sig_T_diff;
end
% ======================================================================
