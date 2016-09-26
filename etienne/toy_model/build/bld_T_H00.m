% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_T_H00.m
%
% Examine the effects of H_00' (what's left after parameterizing H') 
% in the surface energy budget. 
% ======================================================================


%% Param H_00' = {c*P' or c*T'} | Full xiU' and E'

vars_ind = {'P','T'};   % variables to project upon H_00'

% loop through vars_ind
for i=1:length(vars_ind)

  % assign var_ind(i) to X and project H00H00 onto it
  eval(['XX = ' char(vars_ind(i)) char(vars_ind(i)) ';']);
  c = regrs(H00H00,XX);
 
  % as before compute T' and its associated Var(T)
  if strcmp(char(vars_ind(i)),'T')
    bld = (1./xmonth(kappa+c)).* ...
            ( FF - L*EE - xiUxiU + xmonth(mu).*mm );
  else
    bld = (1./xmonth(kappa)).* ...
              ( FF - L*EE - xiUxiU + xmonth(mu).*mm - xmonth(c).*XX);
  end
  bld_Var = anomaly_Var(bld);

  Z = bld_Var;
  name = ['bld_T_H00-' char(vars_ind(i))];
  plot_tm_bias_T;

  % And over correction

end

% ======================================================================

%break

%% Set H_00'=0  | Full xiU , E'

bld = (1./xmonth(kappa)).*( FF - L*EE + xmonth(mu).*mm - xiUxiU );
bld_Var = anomaly_Var(bld);

Z = bld_Var;
name = 'bld_T_H00=0';
plot_tm_bias_T;

   %% Again very interesting stuff. Similar behavior in both models
   %% A param on H_0' induces a negative bias in dry regions and most
   %% of the globe. But a quite large postive bias in observed in,
   %% namely, parts of Africa and the middle east.

% ======================================================================
