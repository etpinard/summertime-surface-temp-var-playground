% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_T_OmegaU.m
%
% Examine the effects of OmegaU' (the combined res. E_00' + H_00') 
% in the surface energy budget. 
% ======================================================================

%% General plotting options
cvec = [-2:0.25:3]; color_handle = @color_tm3;
bins = [-2:0.1:5]; yval = 3.5;
opt_overlay = 0;
%%----------------------------------------------------------------------

% Param xiU'
if ~exist('gam_T') || ~exist('gam_P')
  [gam_T,xiU0xiU0] = regrs(xiUxiU,TT); 
  gam_P = regrs(xiU0xiU0,PP); end         % find a better notation


% Define OmegaU'
OmegaUOmegaU = L*E00E00 + H00H00;
% ----------------------------------------------------------------------

%% Param. OmegaU'=c*T' | Param. xiU'=gam*T'

if ~exist('c_Omega')
  c_OmegaU = regrs(OmegaUOmegaU,TT); end

bld = (1./xmonth(kappa+c_OmegaU)).* ...
                 ( (1-xmonth(lambda)).*F0F0 - xmonth(alpha).*PP  ...
                    - L*(xmonth(e_m.*Fbar)).*mm + xmonth(mu).*mm );
bld_Var = anomaly_Var(bld);

name = 'bld_T_OmegaU-T';
Z = bias(bld_Var,Var_T);
mystats(Z); 
plot_summeravg; %plot_all; 

  %% Over-correction !!! Even though correlation of OmegaU are most 
  %% significant with T (correlations/param_residual.m)

% ======================================================================

%break

%% Set OmegaU'=0 | Param. xiU'=gam_T*T' + gam_P*P'

bld = (1./xmonth(kappa)).* ...
              ( (1-xmonth(lambda)).*F0F0 - xmonth(alpha+gam_P).*PP ...
                    - L*(xmonth(e_m.*Fbar)).*mm + xmonth(mu).*mm );
%bld = (1./xmonth(kappa)).* ...
%              ( (1-xmonth(lambda)).*F0F0 - xmonth(alpha).*PP ...
%                    - L*(xmonth(e_m.*Fbar)).*mm + xmonth(mu).*mm );
bld_Var = anomaly_Var(bld);

name = 'bld_T_OmegaU=0';
Z = bias(bld_Var,Var_T);
mystats(Z); 
plot_summeravg; %plot_all; 

  %% (03/13) the best (physically consistent) toy model so far.

% ======================================================================
