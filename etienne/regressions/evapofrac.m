%%% Can we improve out E' parameterization by using the evaporative 
  % fraction as function to regress.
  %
  % coded for opt_anom_Var='Var'
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

% Define Ef, the evaporative fraction
if ~exist('Ef')
  Ef = L*E./F;
  [Efbar,EfEf,Var_Ef] = anomaly(Ef,opt_anom_Var); end
% ----------------------------------------------------------------------

% get specific humidity (only in ccsm3) 
if strcmp(model_name,'ccsm3') && ~exist('qq')
  [junk1,junk2,qq,Var_q] = getnewvar('huss',opt_anom_Var); end
% ----------------------------------------------------------------------

% Call regrs_single.m and regrs_single_plot.m
var_before = 'Ef';	
if strcmp(model_name,'ccsm3')
  vars_after = {'m','F','q'};
else
  vars_after = {'m','F'}; end

regrs_single

opt_monthly = 0;
cvec = [0:0.1:1]; color_handle = [];
bins = [0:0.05:1.5]; yval = 2.5;
regrs_single_plot
% ======================================================================
