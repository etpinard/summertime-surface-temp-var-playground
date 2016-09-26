% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% tm_mar15_Tsk.m 
%
% Toy model of March 15 using T(skin) instead of T(2m).
% Var(T) as functions of only Var(F_0) and Var(P).
% 
% We must re-paremterized xiU' and H' via tm_param_skin.m
% Otherwise, all paremeters are computed in tm_param.m
% Note that the moisture budget is left unchanged.
% ======================================================================

%% Extract Tsk and compute new parameters
tm_param_skin;
% ======================================================================


%% Chi: the coupling coefficients
chi_sk = (e_m.*Fbar-mu_sk/L).*tau_s;
% ----------------------------------------------------------------------

%% Var(T)

tm_Var = 1./(kappa_sk+gam_T_sk).^2.* ...
         ( (1-lambda.*(1-chi_sk)).^2.*Var_F0 + ...
           (alpha + L*chi_sk.*(1-r-b)).^2.*Var_P );

Z = tm_Var;
name = 'tm_mar15_Tsk';
flag_sk = 1;
plot_tm_bias_T;
clear flag_sk       % to avoid confusion
% ======================================================================
