%%% Program that presents some snow related variables
	%
	%	Thus far, snw.cdf and mrfso.cdf are shown.
	%
	%	Plotting is automated using plot_summeravg.m
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%%% 1) snw.cdf

	% extract the netCDF using getnewvar.m
	% this is snow in summer!!
if ~exist('snw') || ~exist('snwbar') || ~exist('snwsnw')
	if strcmp(opt_anom_Var,'Var')
		[snw,snwbar,snwsnw,Var_snw] = getnewvar('snw',opt_anom_Var);
	else
		[snw,snwbar,snwsnw,sig_snw] = getnewvar('snw',opt_anom_Var);
	end
end

%{
cvec = [0:20:200]; color_handle = [];
bins = [0:5:500]; yval = 0.03;
name = 'snwbar';
Z = snwbar;
mystats(Z)
plot_all;
%}

	% time derivative of snw (per month)
dsnwdt = sqmean(ddt(snw))*30*secinday;

cvec = [-200:20:20]; color_handle = [];
bins = [-400:2:20]; yval = 0.03;
name = 'snwddt';
Z = dsnwdt;
mystats(Z)
plot_summeravg;
% ======================================================================

%%% 2) mrfso.cdf

	% extract the netCDF using getnewvar.m
	% this is frozen soil in summer!!
if ~exist('mrfso') || ~exist('mrfsobar') || ~exist('mrfsomrfso')
	if strcmp(opt_anom_Var,'Var')
		[mrfso,mrfsobar,mrfsomrfso,Var_mrfso] = ... 
							getnewvar('mrfso',opt_anom_Var);
	else
		[mrfso,mrfsobar,mrfsomrfso,sig_mrfso] = ... 
							getnewvar('mrfso',opt_anom_Var);
	end
end

%{
cvec = [0:20:200]; color_handle = [];
bins = [0:5:500]; yval = 0.03;
name = 'mrfsobar';
Z = mrfsobar;
mystats(Z)
plot_all; 
%}


	% time derivative of mrfso (per month)
dmrfsodt = sqmean(ddt(mrfso))*30*secinday;

cvec = [-150:10:0]; color_handle = [];
bins = [-200:1:10]; yval = 0.03;
name = 'mrfsoddt';
Z = dmrfsodt;
mystats(Z)
plot_summeravg;
% ======================================================================
