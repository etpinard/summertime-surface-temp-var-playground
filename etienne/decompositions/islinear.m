%%% Verifying that X = Xbar + X' has indeed |X'| << Xbar
	% for all variables.
	% 
	% We compute the a worse-case coefficient of variation:
	% the maximum  monthly stand. dev. (out of %Nmonth values) 
	% divided by the full summer mean.
	%
	% *** In the (current) toy model, the only non-linear terms  
	%		  to "check" is E (= e*m*F), m and F.
	%			Nonetheless, we can inder some information about the
	%			statistical behavior of the other variables as well.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

	
%%% factor in front of the monthly standard deviation (numerator)
factor = 2;				
% ======================================================================


%%% Variables in $vars

for i=1:Nvar

		% allocation the variable
	eval(['Xbar =' char(vars(i)) 'bar;']);
	eval(['sig_X =' 'sig_' char(vars(i)) ';']);

		% averaging over the three summer months
	Xbarbar = sqmean(Xbar);
		% finding the maximum sig_X at every location (lat,lon)
	maxsig = sqz(max(sig_X));
		% ratio at every (lat,lon)
	Z = factor*maxsig./Xbarbar;
	
	switch i	% consistent through all models ... 

		case 1;		% T
			cvec=[0:0.005:0.02]; bins=[0:0.001:0.05]; yval=70;
		case 2;		% m
			cvec=[0:0.1:0.5]; bins=[0:0.01:1.5]; yval = 5;
		case 3;		% mb	%% TO DO !!!
			cvec=[0:0.1:0.5]; bins=[0:0.01:1.5]; yval = 5;
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
	name = ['linear_', char(vars(i))];
		
		%% plot timeseries using ---> plot_summeravg.m
	plot_summeravg;
	
end; 

clear Xbar Xbarbar sig_X maxsig
% ======================================================================
