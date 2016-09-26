%%% Programme that plots sig_X for all variables 
	% found in $vars. That is, all the monthly climatological standard
	% deviations of the "physical" variables, and not the 
	% "derived" variables, of 
	% the toy model as well as the summer mean std on miller maps.
	%
	% Plotting is automated using plot_monthly.m.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Also, make sure that saturation criterion is adequate
%% (check_saturation.m)		...
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% Plotting of all variables by looping though $vars

for i=2:2				% looping though $vars

	% allocating variable in question
	var1 = char(vars(i));
		
		% allocating Z to sig_X of $vars(i)
	eval(['Z = sig_' char(vars(i)) ';']);

		% selecting $cvec, $bins and $yval for $vars(i)
		% convert to mm/day for E, P, R and Rb.
	switch var1

		case 'T';		% T
			cvec = [0:0.25:3]; bins = [0:0.1:5]; yval = 1;
		case 'm';		% m
			%cvec = [0:0.5:10]; bins = [0:0.1:12]; yval = 0.5;
			cvec = [0:0.01:0.05]; bins = [0:0.001:0.15 ]; yval = 80;
		case 'mb';		% mb
			cvec = [0:10:150]; bins = [0:1:200]; yval = 0.05;
		case 'F';		% F		
			cvec = [2:2:20]; bins = [0:0.5:45]; yval = 0.2;
		case 'P';		% P		
			cvec = [0:0.5:3]; bins = [0:0.05:5]; yval = 1.2;
			Z = Z*secinday;
		case 'E';		% E		%% TO DO !!!
			cvec = [0:0.2:4]; bins = [0:0.05:5]; yval = 1.2;
			Z = Z*secinday;
		case 'H';		% H		%% TO DO !!!
			cvec = [0:0.2:4]; bins = [0:0.05:5]; yval = 1.2;
		case 'R';		% R		%% TO DO !!!
			cvec = [0:0.2:4]; bins = [0:0.05:5]; yval = 1.2;
			Z = Z*secinday;
		case 'Rb';		% Rb	%% TO DO !!!
			cvec = [0:0.2:4]; bins = [0:0.05:5]; yval = 1.2;
			Z = Z*secinday;
		otherwise
			disp(['$$$ no plotting options found'])
			break
	end

		% using the default colormap for all (for now)
	color_handle = [];

		% name for output for $vars(i)
	name = ['sig_',char(vars(i))];

		% set opt_mean=1 for the stds. (see plot_summeravg.m)
	opt_mean = 1;

		%% plot timeseries using ---> plot_all.m or plot_summeravg.m
	plot_all;
%	plot_summeravg;

end
% ======================================================================

break

%% Plot also L*E (in W/m^2)  		%% TO DO !!!

cvec = [0:0.2:4]; color_handle = @color_tm;
bins = [0:0.05:5]; yval = 1.2;

name = 'LEbar';
Z = L*Ebar;

plot_all;
% ======================================================================

