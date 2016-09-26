%%% Can we improve out E' parameterization by using the Bowen ratio
  % (=SH/LH) as function to regress.
  %
  % coded for opt_anom_Var='Var'
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Define the anomaly bowen ratio (labeled as Br)
if ~exist('Br')
  [Hs,Hsbar,HsHs,sig_Hs] = getnewvar('hfss',opt_anom_Var); 
  Br = Hs./(L.*E);
  [Brbar,BrBr,Var_Br] = anomaly(Br,opt_anom_Var); end
% ----------------------------------------------------------------------

% check sign of regression coefficient
Z = regrs(BrBr,mm);
mystats(Z,'coef of regrs(BrBr,mm)')
cvec = [-1:0.25:1]; color_handle = [];
bins = [-1.5:0.05:1.5]; yval = 2.5;
name = 'tmp';
plot_summeravg;
% ----------------------------------------------------------------------
break

% Call regrs_single.m and regrs_single_plot.m
var_before = 'Br';	
vars_after = {'m','F'};

regrs_single

opt_monthly = 0;
cvec = [0:0.1:1]; color_handle = [];
bins = [0:0.05:1.5]; yval = 2.5;
regrs_single_plot
% ======================================================================

%% Using the Bowen ratio yields a different residual distribution.
%% In dry region, using E' is much better.
%% However, in wet and mixed regions, 
%% Br=Br(m') is better than E=E(F_0) execpt in the
%% deep tropical forests where E=E(F_0) is the best option.
