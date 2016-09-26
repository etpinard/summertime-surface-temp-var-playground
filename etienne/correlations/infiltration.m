%%% Computing the soil moisture infiltration using autolag covariance
	% of the top layer soil moisture
	%
	% Now uses inflt.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% Auto-correlation of the mositure budget residual

	% assuming dm'/dt = 0
rhorho = PP-EE-RR;
sig_rho = anomaly_sig(rhorho);
[corlag_rho,Corlag_rho,pairs_months] = corr_autolag(rhorho,sig_rho);

cvec = [-1:0.1:1]; color_handle = @color_corr3;
bins = [-1:0.01:1]; yval = 3;
Z = sqz(Corlag_rho(1,:,:));
mystats(Z)
name = 'corlag1_rho';
plot_summeravg;


%% Compute and plot the exchange coefficient (a*(m-mb))

if ~exist('arho')

	disp('Computing ... arho');
	
	cov_rho = cova_autolag(rhorho);

	%den = cova_autolag(mm);
	den = cova_autolag(mm-mbmb);
	
	nogood = find(den<=0);
	den(nogood) = NaN;
	arho = cov_rho./den;

		% average of month 1-2 and 2-3
	arho = (sqz(arho(1,:,:))+sqz(arho(3,:,:)))/2;

end

tmp = inflt(mm-mbmb,anomaly_Var(mm-mbmb));

cvec = [0:5:50]; color_handle = [];
bins = [0:0.5:100]; yval = 0.1;
%Z = 1./arho/secinday;
Z = tmp/secinday;
mystats(Z);
name = 'arho';
plot_summeravg;
% ======================================================================

break

%% Compute and plot the infiltration time scale (m/taurho)

if ~exist('taurho')
	disp('Computing ... taurho');
	[taurho,taurho_full,pairs_months] = inflt(mm,sig_m.^2);
end

%% Plotting the results and some stats
cvec = [0:5:50]; color_handle = [];
bins = [0:0.5:100]; yval = 0.1;

	% first for each month pairs
for i=1:length(pairs_months)

	Z = sqz(taurho_full(i,:,:))/secinday;		% tau in days
	mystats(Z);

	name = ['taurho_' num2str(pairs_months(i,1)) ...
														num2str(pairs_months(i,2))];
	
	plot_summeravg			% plot using plot_summeravg.m

end

	% average of month 1-2 and 2-3
Z = taurho/secinday;
mystats(Z);
name = 'taurho';
plot_summeravg;
% ======================================================================
