%%% Program that generates timeseries of the two Toy Model
	% forcing functions, gamma and psi for all the locations generated
	% by locations.m.
	%
	% Using plot_ts, the forcing functions will be acompagnied by
	% their respective standard deviations.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


	sig_gam = anomaly_sig(gam);
end			

	% sig_psi using ---> anomaly_sig.m
if ~exist('sig_psi');
	disp(['Computing ... sig_psi']);
	sig_psi = anomaly_sig(psi);
end
% ======================================================================


%% Time series of gamma, the surface energy forcing function

	% requirements as in plot_ts_locs.m 
tsvals = [-4,4];						% TO DO !!!
cols = [0.34,0.23,0.87];
yvals = 0.6;

name = 'gam';
Z = gam;					
Zbar = [];
sig_Z = sig_gam;

plot_ts_locs;
% ======================================================================

%% Time series of psi, the soil moisture energy function

	% requirements as in plot_ts_locs.m 
tsvals = [-4,4];					% TO DO !!!
cols = fliplr([0.34,0.23,0.87]);
yvals = 0.6;

name = 'psi';
Z = psi*secinday;					
Zbar = [];
sig_Z = sig_psi*secinday;

plot_ts_locs;
% ======================================================================
