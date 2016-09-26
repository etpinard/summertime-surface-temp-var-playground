% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% coef_coupling_skin.m
%
% T(skin) version of coef_coupling.m
% 
% ======================================================================

% Get skin parameters
tm_param_skin;
% ======================================================================

% [unitless] toy model version of the Bowen ratio.
den = makenan(tau_H_sk,'==0');
Z = tau_E./den;
mystats(Z);
cvec = [0:1:7]; color_handle = [];
bins = [0.1:0.05:10]; yval = 1;
name = 'bowen_sk';
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] net moisture time scale affecting sfc engy 
den = makenan((e_m.*Fbar-mu_sk/L),'==0');
Z = 1./den/secinday;		
mystats(Z);
cvec = [-5:0.5:5]; color_handle = [];
bins = [-15:0.05:15]; yval = 2;
name = 'nu_sk';
plot_summeravg; 
% ----------------------------------------------------------------------

% [unitless] ratio of m' time scale to the time scale affecting sfc engy
Z = (e_m.*Fbar-mu_sk/L).*tau_s;
mystats(Z);
cvec = [-2:0.5:2]; color_handle = @color_myjet;
bins = [-3:0.05:3]; yval = 2;
name = 'chi_sk';
plot_summeravg; 
% ----------------------------------------------------------------------

% maybe add (1-lambda(1-chi_sk)) ...
