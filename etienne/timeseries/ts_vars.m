%%% Program that plots the timeseries of the all variables 
	% that computed anomalies of for all the locations 
	% generated by locations.m
	%
	% Using plot_ts, the full variables X will be acompagnied by
	% their climatological means Xbar.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	

%% Plotting timeseries of all variables by first looping though $vars
 % and then looping through the locations (inside plot_ts_locs.m)

for i=1:Nvar				% looping though $vars
		
		% allocating Z and Zbar for $vars(i)
	eval(['Z = ' char(vars(i)) ';']);
	eval(['Zbar = ' char(vars(i)) 'bar;']);
	
		% selecting $tsvals, $cols and $yvals for $vars(i)
		% convert to mm/day for E, P, R and R(b).	TO DO !!!
	switch i

		case 1;		% T
			tsvals = [-4,4]; cols = 'b'; yvals = 0.6;
		case 2;		% m
			tsvals = [-4,4]; cols = 'b'; yvals = 0.6;
		case 3;		% mb
			tsvals = [-4,4]; cols = 'b'; yvals = 0.6;
		case 4;		% F
			tsvals = [-4,4]; cols = 'b'; yvals = 0.6;
		case 5;		% P
			tsvals = [-4,4]; cols = 'b'; yvals = 0.6;
			Z = Z*secinday;	Zbar = Zbar*secinday;					% mm/day
		case 6;		% E
			tsvals = [-4,4]; cols = 'b'; yvals = 0.6;
			Z = Z*secinday;	Zbar = Zbar*secinday;					% mm/day
		case 7;		% H
			tsvals = [-4,4]; cols = 'b'; yvals = 0.6;
		case 8;		% R
			tsvals = [-4,4]; cols = 'b'; yvals = 0.6;
			Z = Z*secinday;	Zbar = Zbar*secinday;					% mm/day
		case 9;		% Rb
			tsvals = [-4,4]; cols = 'b'; yvals = 0.6;
			Z = Z*secinday;	Zbar = Zbar*secinday;					% mm/day

	end

		% name for output for $vars(i)
	name = char(vars(i));

		% not plotting sig_Z --- refer to plot_ts_locs.m
	sig_Z = [];

		%% plot timeseries using ---> plot_ts_locs.m
	plot_ts_locs;

end
% ======================================================================

break




%% Time series of r = R/(P*m) 

for j=1:Nlocs

	ilon = Ilon(j); ilat = Ilat(j);			%	 coordinate indices
		
		% allocating for E, F and m at locations $i
	tmpR = squeeze(R(:,ilat,ilon));
	tmpP = squeeze(P(:,ilat,ilon));
	tmpm = squeeze(m(:,ilat,ilon));

		% likewise for clim. averages
	tmpRbar = squeeze(Rbar(:,ilat,ilon));
	tmpPbar = squeeze(Pbar(:,ilat,ilon));
	tmpmbar = squeeze(mbar(:,ilat,ilon));
	
		% "r"
	Z = tmpR./(tmpP.*tmpm);
	Zbar = tmpRbar./(tmpPbar.*tmpmbar);
	nogood = find(abs(Z)>1e5);
	Z(nogood) = NaN;

		% cheeky move to ts_plot work
	sig_Z = squeeze(sig_E(:,ilat,ilon));	% could be any variable

	name = ['ts', num2str(j) '_R-Pm'];
	
	[min(Z),nanmean(Z),max(Z)]

	col = [0.323,0.12,0.978];

	ts_plot(Z,Zbar,sig_Z,Nyear,col,name);
	bins = [min(Z):1e-4:max(Z)];
	axisval = [bins(1),bins(end),0,0.5e4];
	if j==7; bins=[min(Z):0.5e-5:max(Z)]; 
					 axisval = [bins(1),bins(end),0,1e5];	end
	plot_hist(Z,bins,90,'',['hist_',name],axisval);

end
% ======================================================================

%% Time series of r' = L*RR/(Pbar*mm+PP*mbar) 

for j=1:Nlocs

	ilon = Ilon(j); ilat = Ilat(j);			%	 coordinate indices
		
		% clim. averages (same annual cycle for both m and P)
	tmpPbar = nanmean(squeeze(Pbar(:,ilat,ilon)));
	tmpmbar = nanmean(squeeze(mbar(:,ilat,ilon)));

		% same but for anomalies
	tmpRR = squeeze(RR(:,ilat,ilon));
	tmpPP = squeeze(PP(:,ilat,ilon));
	tmpmm = squeeze(mm(:,ilat,ilon));

	ZZ = tmpRR./(tmpmbar.*tmpPP + tmpmm.*tmpPbar);
	sig_Z = sqrt(Ntime/(Ntime-1)*anomaly(ZZ.*ZZ,Nyear));
		
	name = ['ts', num2str(j) '_R-Pm_anom'];

	[min(ZZ),nanmean(ZZ),max(ZZ)]
	
	col = fliplr([0.323,0.92,0.278]);

	ts_plot(ZZ,NaN,sig_Z,Nyear,col,name);
	bins = [min(ZZ):1e-5:max(ZZ)];
	axisval = [bins(1),bins(end),0,0.5e4];
	if j==7; bins=[min(ZZ):0.5e-5:max(ZZ)]; 
					 axisval = [bins(1),bins(end),0,1e4];	end
	plot_hist(Z,bins,90,'',['hist_',name],axisval);

end
% ======================================================================
