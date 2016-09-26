% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_T_roundoff.m 
%
% Check if the sfc engy budget is conserved ...
% This should output nothing more than runoff errors.
% ======================================================================


%% Budget check.

bld = (1./xmonth(kappa)).*( FF - L*EE - H0H0 - xiUxiU );
bld_Var = anomaly_Var(bld);

Z = bld_Var;
name = 'bld_T_roundoff'; 

plot_tm_bias_T;
plot_tm_sig_T;
plot_tm_sig_T_diff;

   %% By including the residual we make NO errors.

% ======================================================================
