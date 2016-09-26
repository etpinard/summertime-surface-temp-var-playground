% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_T_xiU.m 
%
% Examine the effects of xiU (the residual) in the surface energy
% budget. 
% ======================================================================

%% General plotting options
cvec = [-2:0.25:3]; color_handle = @color_tm3;
bins = [-2:0.1:5]; yval = 3.5;
opt_overlay = 0;
% ----------------------------------------------------------------------

%% Param xiU' = {gam X' or gam P'} | Full H_0' and E'

vars_ind = {'P','T'};   % variables to project upon xiU'

% loop through vars_ind
for i=1:length(vars_ind)

  % assign var_ind(i) to X and project xiUxiU onto it
  eval(['XX = ' char(vars_ind(i)) char(vars_ind(i)) ';']);
  gam = regrs(xiUxiU,XX);
 
  % as before compute T' and its associated Var(T)
  if strcmp(char(vars_ind(i)),'T')
    bld = (1./xmonth(kappa+gam)).*( FF - L*EE - H0H0 );
  else
    bld = (1./xmonth(kappa)).*( FF - L*EE - H0H0 - xmonth(gam).*XX);
  end

  bld_Var = anomaly_Var(bld);

  name = ['bld_T_xiU-' char(vars_ind(i))];
  Z = bias(bld_Var,Var_T);
  mystats(Z); 
  plot_summeravg; %plot_all; 

end

   %% Very interesting stuff. Great news actually. NICE!
   %% In the HadGEM1, param xiU' with T' removes essentially all bias
   %% everywhere.
   %% In the CCSM 3.0, a param with P' removes all bias in the deep
   %% tropical forests. A param with T' is best for the high lats.

% ======================================================================

%break

%% Set xiU'=0 | Full H_0' and E'

bld = (1./xmonth(kappa)).*( FF - L*EE - H0H0 );
bld_Var = anomaly_Var(bld);

name = 'bld_T_xiU=0';
Z = bias(bld_Var,Var_T);
mystats(Z); 
plot_summeravg; %plot_all; 

   %% Without the residual, we have a POSITIVE bias everywhere,
   %% largest in deep tropical forests.

% ======================================================================
