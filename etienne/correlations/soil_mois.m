%%% Correlations of the variables included is the soil moisture 
	% budget equation. Correlations between m, P, E, R and (NOW!) the 
	%	moisture budget residual (xim) are computed.
	%
	%	Note that in reality, evapotransipiration from the top layer 
	% is only a fraction of the full E term. However, by assuming 
	% E_top' = eta * E'		where 0 <= eta <= 1
	% the following correlation map are correct.
	% 
	% Uses corr_pairs.m for computation.
	%
	% Moreover, we seek the causes of why corr(E,P)<0 in moist regions.
	%	
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Selecting the variables to pair up, vars_pairs
vars_pairs = {'m','P','E','R','xim'};						% top
%vars_pairs = {'mb','P','E','Rb'};							% bottom
% ======================================================================

%%% Call corr_pairs.m for computations
opt_corlag = 1;
corr_pairs
% ======================================================================

%%% Call corr_pairs_plot.m for plotting
opt_monthly = 0;
corr_pairs_plot
% ======================================================================

break

%%% How can corr(E,P) < 0 over moist soils?

% if dm'/dt is indeed negligible then % 
%		<E',P'> = Var_E + <E',R'> + <E',rho'>

	% computing the needed covariances
if ~exist('cov_EP')
	disp('Computing ... cov_EP , cov_ER and cov_Em');
	cov_EP = cova_inst(EE,PP);
	cov_ER = cova_inst(EE,RR);
	cov_Em = cova_inst(EE,mm);
end

	% and the infiltration (or exchange) time scale
if ~exist('taurho')
	disp('Computing ... taurho');

	cov_m = cova_autolag(mm);
	%cov_m = cova_auto(mm-mbmb);

	rhorho = PP-EE-RR;
	cov_rho = cova_autolag(rhorho);
	taurho = cov_m./cov_rho;
	taurho = x2d((sqz(taurho(1,:,:))+sqz(taurho(3,:,:)))/2);
end

	%%% HOLD UP, this assumes that E' is the correct value 

taurho = x2d(inflt(mm,sig_m));
mystats(taurho);
Z = abs((sig_E.^2 + cov_ER + 1./taurho.*cov_Em)./cov_EP);
Z = abs((sig_E.^2 + cov_ER)./cov_EP);
	
	%% does not change much ...

mystats(Z);
name = 'cov_EP-check2';
cvec = [0:0.5:3]; color_handle = [];
bins = [0:0.05:3]; yval = 3;
plot_summeravg;
% ======================================================================

