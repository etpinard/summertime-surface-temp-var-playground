%%% Compute the coefficient of variation for all (natural and derived)
	% variables. That is, the ratio of the standard deviation to
	% the mean.
	%	
	%	Plotting is automated using plot_all.m
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

	
%%% Variables in $vars

for i=2:3

		% allocation the variable
	eval(['Xbar =' char(vars(i)) 'bar;']);
	eval(['sig_X =' 'sig_' char(vars(i)) ';']);

		% compute the coefficient of variation (Nmonth x Nlat x Nlon)
	Z = sig_X./Xbar;			
	
	switch i	% consistent through all models ... 

		case 1;		% T
			cvec=[0:0.005:0.02]; bins=[0:0.001:0.05]; yval=70;
		case 2;		% m
			cvec=[0:0.05:0.6]; bins=[0:0.01:1.2]; yval = 8;
		case 3;		% mb	
			cvec=[0:0.02:0.2]; bins=[0:0.01:0.5]; yval = 25;
		case 4;		% F	
			cvec=[0:0.02:0.2]; bins=[0:0.01:0.5]; yval = 15;
		case 5;		% P	
			cvec=[0:0.2:2]; bins=[0:0.01:3]; yval = 2;
		case 6;		% E		
			cvec=[0:0.2:2]; bins=[0:0.01:3]; yval = 3;
		case 7;		% H		%% TO DO !!!
			cvec=[0:2e-3:0.02]; bins=[0:1e-3:1e-1]; yval = 1e-1;
		case 8;		% R		%% TO DO !!!
			cvec=[0:0.5:5]; bins=[0:0.1:10]; yval = 0.5;
		case 9;		% Rb	%% TO DO !!!

	end
	
		% using the default colormap for all (for now)
	color_handle = [];

		% name for output for $vars(i)
	name = ['coeffvar_', char(vars(i))];
		
		%% plot timeseries using ---> plot_summeravg.m
	%plot_all;
	plot_summeravg;
	
end; 

clear sig_X Xbar
% ======================================================================

break

%%% Derived variables 

	%% TO DO !!!


