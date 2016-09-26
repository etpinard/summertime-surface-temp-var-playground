%%% Program that computes the coefficient of variation 
	% of temperature for all grid points and plots it against
	% the mean soil moisture content as a scatter plots.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , dist.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Compute and plot c_v(T) vs mbar month-by-month

% coefficient of variation of temperautre for all summer months
cv_T = sig_T./Tbar;					%	Nmonth x Nlat x Nlon

for i=1:Nmonth			% looping through the summer months
	
		% allocating for month $i
	cv_T1 = squeeze(cv_T(i,:,:));
	mbar1 = squeeze(mbar(i,:,:));
	sig_T1 = squeeze(sig_T(i,:,:));
	sig_m1 = squeeze(sig_m(i,:,:));

		% plotting using evapofrac_plot_full.m
	name = ['cvT_m',num2str(i)];
	evapofrac_plot_full(mbar1,cv_T1,[0,55],[0,0.016],[],name);
	
		% plotting using evapofrac_plot_full.m
	name = ['sigT_m',num2str(i)];
	evapofrac_plot_full(mbar1,sig_T1,[0,55],[0,5],[],name);
		
		% plotting using evapofrac_plot_full.m
	name = ['sigT_sigm',num2str(i)];
	evapofrac_plot_full(sig_m1,sig_T1,[],[0,5],[],name);

end
% ======================================================================
