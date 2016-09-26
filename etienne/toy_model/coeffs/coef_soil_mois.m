% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% coef_soil_mois.m
%
% Distributions of the soil moisture budget coefficients.
% 
% ======================================================================


% [unitless] fraction of P' which runoffs
Z = r;		
mystats(Z);
cvec = [0:0.1:0.8]; color_handle = [];
bins = [-1:0.01:2]; yval = 10;
name = 'r';
opt_overlay=0;
plot_summeravg; 
% ----------------------------------------------------------------------

% [unitless] fraction of P' which infiltrates (or drains)
Z = b;		
mystats(Z);
cvec = [0:0.1:0.8]; color_handle = [];
bins = [-1:0.01:2]; yval = 10;
name = 'b';
opt_overlay=1;
plot_summeravg; 
% ----------------------------------------------------------------------

% [unitless] net soil uptake by P'
Z = (1-r-b);		
mystats(Z);
cvec = [0:0.1:0.8]; color_handle = [];
bins = [-1:0.01:2]; yval = 10;
name = '1-r-b';
opt_overlay=1;
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] infiltration time scale
Z = (1./a)/secinday;		
mystats(Z);
cvec = [0:5:30]; color_handle = [];
bins = [0:1:100]; yval = 0.15;
name = '1_a';
opt_overlay=0;
plot_summeravg; 
% ----------------------------------------------------------------------

% [days] net soil moisture anomaly time scale
Z = tau_s/secinday;		
mystats(Z);
cvec = [0:5:30]; color_handle = [];
bins = [0:1:100]; yval = 0.15;
name = 'tau_s';
opt_overlay=0;
plot_summeravg; 
% ----------------------------------------------------------------------
