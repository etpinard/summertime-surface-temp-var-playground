% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% check_mar15.m 
%
% Relative contribtuion of both Var(P) and Var(F_0)
% in the toy model equations of March 15. 
% 
% ======================================================================

%% General plotting options
cvec = [0:0.1:1]; color_handle = [];
bins = [0:0.01:1.02]; yval = 20;
opt_overlay = 0;
% ----------------------------------------------------------------------

%% Chi: the coupling coefficients
chi = (e_m.*Fbar-mu/L).*tau_s;
% ----------------------------------------------------------------------

%% Var(m)

% tm_Var but w/o the leading factor
den = ( (1-(r+b)).^2.*Var_P + (lambda/L).^2.*Var_F0 );

% 1) Var(P) term
Z = ((1-(r+b)).^2.*Var_P)./den;
mystats(Z); 
name = 'tm_mar15_m-Var_P';
plot_summeravg; 

% 2) Var(F_0) term
Z = ((lambda/L).^2.*Var_F0)./den;
mystats(Z); 
name = 'tm_mar15_m-Var_F0';
plot_summeravg; 
% ======================================================================

%% Var(T)

% tm_Var but w/o the leading factor
den   = ( (1-lambda.*(1-chi)).^2.*Var_F0 + ...
           (alpha + L*chi.*(1-r-b)).^2.*Var_P );

% 1) Var(P) term
Z = ((alpha + L*chi.*(1-r-b)).^2.*Var_P)./den;
mystats(Z); 
name = 'tm_mar15_T-Var_P';
plot_summeravg; 

% 2) Var(F_0) term
Z = ((1-lambda.*(1-chi)).^2.*Var_F0)./den;
mystats(Z); 
name = 'tm_mar15_T-Var_F0';
plot_summeravg; 
% ======================================================================
