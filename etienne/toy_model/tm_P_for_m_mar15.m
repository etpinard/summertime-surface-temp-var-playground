% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% tm_P_for_m_mar15.m 
%
% Same as tm_mar15.m but now using P' instead of m'.
%
% Note that Var(m) is meaningless in this framework.
% ======================================================================

%% get new coefficients
tm_param_P_for_m;
% ----------------------------------------------------------------------

%% if called from another procedure to get tm_Var_m and tm_Var_T.
if ~exist('opt_plot')
  opt_plot = 1; end
% ----------------------------------------------------------------------


%% Var(T)

tm_Var_T = 1./(kappa+gam_T).^2.* ...
           ( (1-lambda_P).^2.*Var_F0 + ...
           (alpha + L*(nu_E-nu_H)).^2.*Var_P );

if opt_plot
  Z = tm_Var_T;
  name = 'tm_P_for_m_mar15_T';
  plot_tm_bias_T;
%  plot_tm_sig_T;
%  plot_tm_sig_T_diff;
end
% ======================================================================
