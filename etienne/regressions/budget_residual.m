%%% Seeking the best parameterization for xiU and xim, the two budget
  % residuals.
	% 
	% Uses regrs_single.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

% Plotting options
opt_monthly = 0;
cvec = [0:0.1:1]; color_handle = [];
bins = [0:0.05:1.5]; yval = 2.5;

%% Compute the two budget residuals xiU and xim
ximxim = PP-EE-RR;								% infiltration + storage
sig_xim = anomaly_sig(ximxim);		
xiUxiU = FF-L*EE-HH;							% storage + T advection 
sig_xiU = anomaly_sig(xiUxiU);		

if strcmp(opt_anom_Var,'Var')
	Var_xim = anomaly_Var(ximxim);
	Var_xiU = anomaly_Var(xiUxiU);
else
	sig_xim = anomaly_sig(ximxim);
	sig_xiU = anomaly_sig(xiUxiU);
end
% ======================================================================


%%% xi_U'
var_before = 'xiU';		
vars_after = {'F','F0','H','T','m','P'};    % include wind speed too!

%regrs_single
%regrs_single_plot
% ======================================================================

%%% xi_m'
var_before = 'xim';		
vars_after = {'m','P','T'};

regrs_single
regrs_single_plot

regrs_multiple
regrs_multiple_plot
% ======================================================================


%%% Maybe try multiple projections with xim
