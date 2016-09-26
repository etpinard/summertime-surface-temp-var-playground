%%% Investigating the magnitude of residual in the soil moisture
  % budget of the top layer soil layer.
  %
  % Both, mean and anomaly budget are analysed. 
  % Note that, We are neglecting the time derivative.
  %
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% Is Pbar - Ebar - Rbar ? everywhere ?

check_balance = Pbar - Ebar - Rbar;     

name = 'balance_soil-mean';       
Z = check_balance*secinday;               % in mm / day
mystats(Z); 
cvec = [-5:1:5]; color_handle = [];
bins = [-5:0.1:5]; yval = 1;
%plot_summeravg;
plot_all;

  %% Both models agree quite well. Notice that we have negative
  %% residuals as well as positive ones. 
  %% Positive --> missing storage + infiltration 
  %%  (make sense, in the moist low-lat regions)
  %% Negative --> missing melting snow in high lats (a source) +
  %%  evaporation is also originating from the deeper layer.

% ======================================================================


%% Is 0 = P' - E' - R' ? everywhere ?

% compute the required covariances
if ~exist('cov_PE'); cov_PE = cova_inst(PP,EE); end
if ~exist('cov_PR'); cov_PR = cova_inst(PP,RR); end
if ~exist('cov_ER'); cov_ER = cova_inst(EE,RR); end

check_balance = ( Var_P + Var_E + Var_R ...
                  - 2*cov_PE - 2*cov_PR + 2*cov_ER );

name = 'balance_soil-anom';
Z = sqrt(check_balance)*secinday;        % in mm / day
mystats(Z); 
cvec = [-0.2:0.2:2]; color_handle = [];
bins = [-1:0.05:4]; yval = 1.5;
%plot_summeravg; 
plot_all;

  %% More prounced in wet regions
  %% esp. in the HadGEM1. Perhaps an infiltration (~ P') sink
  %% signature. 

  %% For most analysis of the soil moisture residual, xi_m' , see
  %% scales/soil_mois.m

% ======================================================================
