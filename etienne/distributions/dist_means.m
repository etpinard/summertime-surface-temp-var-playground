%%% Programme that plots Xbar for all variables 
	% found in $vars. That is, all the monthly climatological mean
	% "physical" variables, and not the "derived" variables, of 
	% the toy model as well as the full summer mean on miller maps.
	%
	% Plotting is automated using plot_all.m (or plot_summeravg.m)
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Also, make sure that saturation criterion is adequate
%% (check_saturation.m)
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Select either all summer months (1) or summer-avg (0)
opt_plot_all = 0;
% ----------------------------------------------------------------------


%% Plotting of all variables by looping though $vars

for i=9:9				% looping though $vars
	
	% allocating variable in question
	var1 = char(vars(i));

	% allocating Z to Xbar of $vars(i) , if exist
	eval(['Z = ' char(vars(i)) 'bar;']);

		% selecting $cvec, $bins and $yval for $vars(i)
		% convert to mm/day for E, P, R and Rb.
		% convert K to deg C for T.
	switch var1

		case 'T';		% T
			cvec = [-10:2:30]; bins = [-10:0.5:40]; yval = 0.1;
			Z = Z - 273.15;
		case 'm';		% m
			cvec = [0:2:40]; bins = [0:0.5:50]; yval = 0.1;
		case 'mb';		% mb
			cvec = [0:100:1500]; bins = [0:10:1500]; yval = 7e-3;
		case 'F';		% F		
			cvec = [300:50:600]; bins = [250:5:700]; yval = 0.01;
		case 'P';		% P		
			cvec = [0:1:7]; bins = [0:0.05:10]; yval = 1.2;
			Z = Z*secinday;
		case 'E';		% E		%% TO DO !!!
			cvec = [0:0.2:4]; bins = [0:0.05:5]; yval = 1.2;
			Z = Z*secinday;
		case 'H';		% H		%% TO DO !!!
			cvec = [0:0.2:4]; bins = [0:0.05:5]; yval = 1.2;
		case 'R';		% R		
			cvec = [0:0.2:1.2]; bins = [0:0.01:4]; yval = 5;
			Z = Z*secinday;
		case 'Rb';		% Rb	%% TO DO !!!
			cvec = [0:0.2:4]; bins = [0:0.05:5]; yval = 1.2;
			Z = Z*secinday;
		otherwise
			disp(['$$$ no plotting options found'])
			break
	end

	% some stats
	mystats(Z,var1)
	
	% using the default colormap for all (for now)
	color_handle = [];

	% set opt_x_cvec to 'add_both' for consistent contours
	opt_x_cvec = 'add_both';

	% name for output for $vars(i)
	name = [char(vars(i)),'bar'];

	%% plot timeseries using ---> plot_all.m or plot_summeravg.m
	if opt_plot_all
		plot_all;
	else
		plot_summeravg;
	end

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
