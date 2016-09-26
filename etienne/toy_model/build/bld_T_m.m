% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_T_m.m
%
% Examine the effects of m' (the net effects ...) 
% in the surface energy budget. 
% ======================================================================

%% General plotting options
cvec = [-2:0.25:3]; color_handle = @color_tm3;
bins = [-2:0.1:5]; yval = 3.5;
opt_overlay = 1;                    % yes yes
%% ----------------------------------------------------------------------


%% Set m'=0 | Full xiU , E_00' and H_00'

bld = (1./xmonth(kappa)).* ...
                 ( (1-xmonth(lambda)).*F0F0 - xmonth(alpha).*PP  ...
                    - L*E00E00 - H00H00 - xiUxiU );
bld_Var = anomaly_Var(bld);

name = 'bld_T_m=0';
Z = bias(bld_Var,Var_T);
mystats(Z); 
plot_summeravg; %plot_all; 

% ======================================================================
