% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_Tsk_H00.m
%
% T(skin) version of bld_T_H00.m
% ======================================================================


% Get skin parameters and set flag_sk=1 for all plots here
tm_param_skin;
flag_sk = 1;
% ----------------------------------------------------------------------

%% Param H_00' = {c*P' or c*Tsk'} | Full xiU' and E'

vars_ind = {'P','Tsk'};   % variables to project upon H_00'

% loop through vars_ind
for i=1:length(vars_ind)

  % assign var_ind(i) to X and project H00H00 onto it
  eval(['XX = ' char(vars_ind(i)) char(vars_ind(i)) ';']);
  c = regrs(H00H00_sk,XX);
 
  % as before compute Tsk' and its associated Var(Tsk)
  if strcmp(char(vars_ind(i)),'Tsk')
    bld = (1./xmonth(kappa_sk+c)).* ...
            ( FF - L*EE - xiUxiU + xmonth(mu_sk).*mm );
  else
    bld = (1./xmonth(kappa_sk)).* ...
              ( FF - L*EE - xiUxiU + xmonth(mu_sk).*mm - xmonth(c).*XX);
  end
  bld_Var = anomaly_Var(bld);

  Z = bld_Var;
  name = ['bld_Tsk_H00-' char(vars_ind(i))];
  plot_tm_bias_T;

end

% ======================================================================

%break

%% Set H_00'=0  | Full xiU , E'

bld = (1./xmonth(kappa_sk)).*( FF - L*EE + xmonth(mu_sk).*mm - xiUxiU );
bld_Var = anomaly_Var(bld);

Z = bld_Var;
name = 'bld_Tsk_H00=0';
plot_tm_bias_T;

  %%

% ======================================================================

clear flag_sk
