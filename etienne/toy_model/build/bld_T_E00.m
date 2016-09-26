% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_T_E00.m
%
% Examine the effects of E_00' (what's left after parameterizing E') 
% in the surface energy budget. 
% ======================================================================


%% Param E_00'={c*m_b' or c*T'} | Full xiU' and H_0'

vars_ind = {'mb','T'};   % variables to project upon E_00'

% loop through vars_ind
for i=1:length(vars_ind)

  % assign var_ind(i) to X and project E00E00 onto it
  eval(['XX = ' char(vars_ind(i)) char(vars_ind(i)) ';']);
  c = regrs(E00E00,XX);
 
  % as before compute T' and its associated Var(T)
  if strcmp(char(vars_ind(i)),'T')
    bld = (1./xmonth(kappa+L*c)).* ...
            ( (1-xmonth(lambda)).*F0F0 - xmonth(alpha).*PP - ...
               L*(xmonth(e_m.*Fbar)).*mm - H0H0 - xiUxiU );
  else
    bld = (1./xmonth(kappa)).* ...
            ( (1-xmonth(lambda)).*F0F0 - xmonth(alpha).*PP - ...
               L*(xmonth(e_m.*Fbar)).*mm - H0H0 - xiUxiU ...
               - L*xmonth(c).*XX );
  end

  bld_Var = anomaly_Var(bld);

  Z = bld_Var;
  name = ['bld_T_E00-' char(vars_ind(i))];
  plot_tm_bias_T;

end
% ======================================================================

%break

%% Set E_00'=0 | Full xiU' and H_0'

bld = (1./xmonth(kappa)).* ...
                 ( (1-xmonth(lambda)).*F0F0 - xmonth(alpha).*PP - ...
                      L*(xmonth(e_m.*Fbar)).*mm - H0H0 - xiUxiU );
bld_Var = anomaly_Var(bld);

Z = bld_Var;
name = 'bld_T_E00=0';
plot_tm_bias_T;

  %% Better behaved than after the H_0' param except in deep tropical
  %% forests where the results are worst (positive bias). Why???
  %% Remember in some these place Var(T) ~ 0 K.
  %% The middle east however is fine here. 
  %% Also note that, this is without using the dry algorithm.

% ======================================================================

%break

%% Set E_00'=0 w/ 'dry' algorithm | Full xiU' and H_0'

% call param_evapo using the 'dry' option
if ~exist('e_m2') || ~exist('e_F2')
  [e_m2,e_F2,E00E002,lambda2] = ...
    param_evapo(EE,mm,F0F0,mbar,Fbar,'dry',m); end
% ----------------------------------------------------------------------

bld = (1./xmonth(kappa)).* ...
                 ( (1-xmonth(lambda2)).*F0F0 - xmonth(alpha).*PP - ...
                      L*(xmonth(e_m2.*Fbar)).*mm - H0H0 - xiUxiU );
bld_Var = anomaly_Var(bld);

Z = bld_Var;
name = 'bld_T_E00=0_dry';
plot_tm_bias_T;

  %% Surprising results considering the results from tm_m_GCM.m
  %% Great agreement between models!
  %% No real improvement in dry regions. Higher bias in bounding 
  %% regions such as around the Amazon, Congo and Siberia.

% ======================================================================
