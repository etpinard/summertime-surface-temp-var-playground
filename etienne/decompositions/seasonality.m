%%% Determines the level of accuracy gained by a monthly decomposition
	%	versus a single summer (as whole) mean. That is, the imporatance 
	% of the seasonal cycle.
	%
	% We compare
	%	 X(lat,lon,time) = Xbarbar(lat,lon) + XX(lat,lon,time) vs.
	%	 X(lat,lon,time) = Xbar(lat,lon,time mod $Nmonth) + XX(lat,lon,time)
	%
	%  by taking the ratio of the maxmimum time-dependent Xbar vs.
	%  the constant Xbar.
	%
	%	 *** This is actually not too important in terms of the
	%			 formulating the toy model.
	%			 But it does give us huge insight on the season cycle
	%			 of each variable and parameter.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%%% Variables in $vars

for i=1:Nvar

		% allocation the variable
	eval(['Xbar =' char(vars(i)) 'bar;']);
		
	%% comptuing the ratio in question
		% averaging over the three summer months
	Xbarbar = sqmean(Xbar);
		% substracting the full summer mean  using x2d.m
	dXbar = abs(Xbar-x2d(Xbarbar));
		% finding the maximum Xbar at every location (lat,lon)	
	num = sqz(max(dXbar));									
		% ratio at every (lat,lon)
	Z = num./Xbarbar;

	switch i	% consistent through all models ... 

		case 1;		% T
			cvec=[0:2e-3:0.02]; bins=[0:1e-3:1e-1]; yval=0.1;
		case 2;		% m
			cvec=[0:0.02:0.24]; bins=[0:1e-2:1]; yval=0.1;
		case 3;		% mb	%% TO DO !!!
			cvec=[0:0.02:0.24]; bins=[0:1e-2:1]; yval=0.1;
		case 4;		% F	
			cvec=[0:1e-2:0.1]; bins=[0:5e-3:1e-1]; yval=20;
		case 5;		% P	
			cvec=[0:0.1:1]; bins=[0:1e-2:1e-1]; yval=4.5;
		case 6;		% E		
			cvec=[0:0.1:1]; bins=[0:1e-2:1e-1]; yval=4.5;
		case 7;		% H		%% TO DO !!!
			cvec = [0:0.2:4]; bins = [0:0.05:5]; yval = 1.2;
		case 8;		% R		%% TO DO !!!
			cvec=[0:1e-2:1e-1]; bins=[0:1e-3:1e-1]; yval=50;
		case 9;		% Rb	%% TO DO !!!
			cvec = [0:0.2:4]; bins = [0:0.05:5]; yval = 1.2;

	end

		% using the default colormap for all (for now)
	color_handle = [];

		% name for output for $vars(i)
	name = ['season', char(vars(i))];
	
		%% plot timeseries using ---> plot_summeravg.m
	plot_summeravg;

end; 

clear Xbar dXbar Xbarbar 
% ======================================================================


%%% alpha, the forcing regression parameter
	
%% comptuing the ratio in question
	% averaging over the three summer months
alphabar = sqmean(alpha);
	% substracting the full summer mean  using x2d.m
dalpha = abs(alpha-x2d(alphabar));
	% finding the maximum alpha at every location (lat,lon)	
num = sqz(max(dalpha));									
	% ratio at every (lat,lon)
Z = num./alphabar;

	% Plotting with plot_summeravg.m
name = 'season_alpha';
cvec = [-1.6:0.2:0.2];
bins = [-2:0.01:2];
yval = 2;
plot_summeravg
clear alphabar dalpha
% ======================================================================


%%% e, the slope of the evaporative fraction

%% comptuing the ratio in question
	% averaging over the three summer months
ebar = sqmean(e);
	% substracting the full summer mean  using x2d.m
de = abs(e-x2d(ebar));
	% finding the maximum e at every location (lat,lon)	
num = sqz(max(de));									
	% ratio at every (lat,lon)
Z = num./ebar;

	% Plottinga with plot_summeravg.m
name = 'season_e';
cvec = [0:0.1:1.5];
bins = [0:0.01:2];
axisval = 6;
plot_summeravg
clear ebar de
% ======================================================================

%% Maybe do the same for kappa, nu, ...
