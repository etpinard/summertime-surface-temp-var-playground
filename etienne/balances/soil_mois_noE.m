%%% Same as soil_mois.m but now investigating the effects of
  % bottom-soil layer evapotranspiration.
  % 
  % In a worst-case scenario, all E would come from the bottom layer
  % And,
  % 
  % 0 = P - R 
  %
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


check_balance = Pbar -0.5*Ebar - Rbar;    % remove ~bottom layer Ebar  

name = 'balance_soil-mean-noE';       
Z = check_balance*secinday;               % in mm / day
mystats(Z); 
cvec = [-5:1:5]; color_handle = [];
bins = [-5:0.1:5]; yval = 1;
plot_summeravg; %plot_all;
% ======================================================================

% compute the required covariances
if ~exist('cov_PE'); cov_PE = cova_inst(PP,EE); end
if ~exist('cov_PR'); cov_PR = cova_inst(PP,RR); end
if ~exist('cov_ER'); cov_ER = cova_inst(EE,RR); end

check_balance = ( Var_P + 0.25*Var_E + Var_R ...
                  - cov_PE - 2*cov_PR + cov_ER );

name = 'balance_soil-anom-noE';
Z = sqrt(check_balance)*secinday;        % in mm / day
mystats(Z); 
cvec = [-0.2:0.2:2]; color_handle = [];
bins = [-1:0.05:4]; yval = 1.5;
plot_summeravg; %plot_all;
% ======================================================================
