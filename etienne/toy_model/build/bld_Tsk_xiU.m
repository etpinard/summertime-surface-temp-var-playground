% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_Tsk_xiU.m
%
% T(skin) version of bld_T_xiU.m
% ======================================================================


% Get skin parameters and set flag_sk=1 for all plots here
tm_param_skin;
flag_sk = 1;
% ----------------------------------------------------------------------

%% Param xiU' = {gam X' or gam P'} | Full H_0' and E'

vars_ind = {'P','Tsk'};   % variables to project upon xiU'

% loop through vars_ind
for i=1:length(vars_ind)

  % assign var_ind(i) to X and project xiUxiU_sk onto it
  eval(['XX = ' char(vars_ind(i)) char(vars_ind(i)) ';']);
  gam = regrs(xiUxiU,XX);
 
  % as before compute Tsk' and its associated Var(Tsk)
  if strcmp(char(vars_ind(i)),'Tsk')
    bld = (1./xmonth(kappa_sk+gam)).*( FF - L*EE - H0H0_sk );
  else
    bld = (1./xmonth(kappa_sk)).*( FF - L*EE - H0H0_sk - xmonth(gam).*XX);
  end

  bld_Var = anomaly_Var(bld);

  Z = bld_Var;
  name = ['bld_Tsk_xiU-' char(vars_ind(i))];
  plot_tm_bias_T;

end

% ======================================================================

%break

%% Set xiU'=0 | Full H_0' and E'

bld = (1./xmonth(kappa_sk)).*( FF - L*EE - H0H0_sk );
bld_Var = anomaly_Var(bld);

Z = bld_Var;
name = 'bld_Tsk_xiU=0';
plot_tm_bias_T;

% ======================================================================

clear flag_sk
