% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_T_Horth.m
%
% Examine the an alternative parameterization scheme for H' where
% orthogonal basis functions are used (see param_damp.m)
% ======================================================================


%% Get the orthongonal basis functions 
%% calling param_damp with the 'orth' option 
if ~exist('kappa2') || ~exist('mu2')
  [kappa2,mu2,H0H02,H00H002,tauH2] = param_damp(HH,TT,mm,'orth'); end
%%----------------------------------------------------------------------

%% Param H' with orthog. basis vectors. | keep full E' and xiU'

check = (1./xmonth(kappa2)).* ...
           ( FF - L*EE + L./xmonth(tauH2).*mm - xiUxiU );
check_Var = anomaly_Var(check);

name = 'bld_T_Horth';
Z = check_Var;
plot_tm_bias_T;

  %% Quite intriguing. Similar behavior between models.
  %% We have a positive bias everywhere, with similar hot spots
  %% than oblique porjections (see bld_T_H00.m).
  %% tauH2 is less than tauH as desired.
  %%
  %% But, kappa looks to be (make a plot maybe) smaller --> +ve bias.

% ======================================================================
