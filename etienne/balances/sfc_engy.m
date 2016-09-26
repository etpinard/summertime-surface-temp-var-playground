%%% Investigating the magnitude of residual in the surface energy
  % budget.
  %
  % Both, mean and anomaly budget are analysed. 
  % Note that, We are neglecting the time derviative.
  %
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% Is Fbar - LEbar - Hsbar -Flubar ? everywhere ?

check_balance = Fbar - L*Ebar - Hsbar - Flubar;   

name = 'balance_engy-mean';       
Z = check_balance;                        % in W/m^2
mystats(Z); 
cvec = [-5:5:25]; color_handle = [];
bins = [-5:1:50]; yval = 0.15;
%plot_summeravg; 
plot_all;

  %% CCSM 3.0 has much more (~ 10 W/m^2) mid-lat and high-lat
  %% locations. In both models, the high arctic and Tibet have the
  %% most (in absolute terms) mean residual. Note that the residual is 
  %% positive everywhere; we are missing a storage term or melting
  %% snow term (most likely I think -- through the strong seasonality
  %% in the extreme high lats).

% ======================================================================

%% Is xiU' = F' - LE' - Hs' - Flu' = 0 ? everywhere ? 

name = 'balance_engy-anom';
Z = sqrt(Var_xiU);              % from anomaly_full.m [in W/m^2]
mystats(Z); 
cvec = [-1:0.5:8]; color_handle = [];
bins = [-1:0.1:10]; yval = 1;
plot_summeravg; 
%plot_all;

  %% Again, huge differences between models. The CCSM 3.0 has much
  %% more residual everywhere (~ 5 W/m^2) with emphasis in the very
  %% wet regions.

  %% For most analysis of the sfc engy residual, xi_U' , see
  %% scales/sfc_engy.m

% ======================================================================

break

%% In the mean with H' = kappa * T'     %% bad !!!
  %% kappa*Tbar is on avg. 5 times bigger than Hbar

[kappa,H0H0] = regrs(HH,TT);			
check_balance = Fbar - L*Ebar - kappa.*Tbar;

name = 'balance-Tbar-kappa';
Z = check_balance;
mystats(Z); 
cvec = [-1:0.5:8]; color_handle = [];
bins = [-1:0.1:10]; yval = 1;
plot_summeravg; %plot_all;
% ======================================================================
