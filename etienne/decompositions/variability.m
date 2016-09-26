%%% Determines if the variability of the mean during summer
	% is of the same order of manigtude as the typical
	%	variability about the mean.
	%
  % We compute the maximum (of $Nmonth values)
	% of the ratio of the monthly mean deviation
	% from the full summer mean to monthly standard deviation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%%% factor in front of the monthly standard deviation (denominator)
factor = 1;		
% ======================================================================


%%% Variables in $vars

for i=1:Nvar

		% allocation the variable
	eval(['Xbar =' char(vars(i)) 'bar;']);
	eval(['sig_X = sig_' char(vars(i)) ';']);

		% averaging over the three summer months
	Xbarbar = sqmean(Xbar);
		% substracting the full summer mean  using x2d.m
	dXbar = abs(Xbar-x2d(Xbarbar));
		% ratio of the deviation in mean with standard deviation
	den = factor*sig_X;
	ratio = dXbar./den;
		% finding the maximum ratio at every location (lat,lon)	
	Z = sqz(max(ratio));									

		% plotting specifications
	cvec = [0:0.1:2.1];
	bins = [0:0.02:3.5];
	axisval = [bins(1),bins(end),0,2];

		%% unless I need to specify for each variable ...

		% using the default colormap for all (for now)
	color_handle = [];

		% name for output for $vars(i)
	name = ['variab_', char(vars(i))];
	
		%% plot timeseries using ---> plot_summeravg.m
	plot_summeravg;
	
end; 

clear ratio Xbar Xbarbar dXbar sig_X nogood den 
% ======================================================================
