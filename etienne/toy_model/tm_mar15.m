% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% tm_mar15.m 
%
% Toy model of March 15. 
% Var(T) and Var(m) as functions of only Var(F_0) and Var(P).
% 
% Here, xiU' and xim' are parameterized.
% As of (03/15), all required parameters are computed in tm_param.m
% ======================================================================

%% if tm_mar15.m is called from another procedure 
%% just to get tm_Var_m and tm_Var_T.
if ~exist('opt_plot')
  opt_plot = 1; end

%% Chi: the coupling coefficients
chi = (e_m.*Fbar-mu/L).*tau_s;
% ----------------------------------------------------------------------

%% Var(m)

tm_Var_m = tau_s.^2.* ...
           ( (1-r-b).^2.*Var_P + (lambda/L).^2.*Var_F0 );

if opt_plot
  Z = tm_Var_m;
  name = 'tm_mar15_m'; 
  plot_tm_bias_m;
  %plot_tm_sig_m;
  %plot_tm_sig_m_diff;
end
% ======================================================================

%% Var(T)

tm_Var_T = 1./(kappa+gam_T).^2.* ...
           ( (1-lambda.*(1-chi)).^2.*Var_F0 + ...
           (alpha + L*chi.*(1-r-b)).^2.*Var_P );

if opt_plot
  Z = tm_Var_T;
  name = 'tm_mar15_T';
  plot_tm_bias_T;
%  plot_tm_sig_T;
%  plot_tm_sig_T_diff;
end
% ======================================================================
