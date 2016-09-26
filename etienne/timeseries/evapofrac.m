%%% Program that generates timeseries of the various
	% evaporative fraction (i.e. lambda) quantities.
	%
	% Using plot_ts, the forcing functions will be acompagnied by
	% their respective standard deviations.
% ======================================================================



%% Time series of L*e*m

	%% Recall we defined e = Ebar/(mbar*Fbar).

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

%% Time series of L*e*m(time,lat,lon)

for j=1:Nlocs

	ilon = Ilon(j); ilat = Ilat(j);			%	 coordinate indices
	
	tmpe = squeeze(e(ilat,ilon));			% "e" at (ilat,ilon)

		% assuming "e" is constant throughout summer
	Z = L*tmpe.*squeeze(m(:,ilat,ilon));				
	Zbar = L*tmpe.*squeeze(mbar(:,ilat,ilon));
	ZZ = L*tmpe.*squeeze(mm(:,ilat,ilon));
	sig_Z = L*tmpe.*squeeze(sig_m(:,ilat,ilon));

	col = [0.123,0.67,0.978];
	name =  ['ts',num2str(j),'_Lem'];

	ts_plot(Z,Zbar,sig_Z,Nyear,col,name);
	bins = [min(Z):0.0005:max(Z)];
	axisval = [bins(1),bins(end),0,0.55e3];
	if j==7; bins=[min(Z):0.5e-5:max(Z)]; 
					 axisval = [bins(1),bins(end),0,1e5];	end
	plot_hist(Z,bins,90,'',['hist_',name],axisval);
	
	name = [name,'m'];
	ts_plot(ZZ,NaN,sig_Z,Nyear,col,name);
	bins = [min(ZZ):0.0005:max(ZZ)];
	axisval = [bins(1),bins(end),0,0.8e3];
	if j==7; bins=[min(ZZ):0.5e-5:max(ZZ)]; 
					 axisval=[bins(1),bins(end),0,1e5]; end
	plot_hist(ZZ,bins,90,'',['hist_',name],axisval);

end
% ======================================================================
%}
%% Time series of e = L*E/(F*m) 

for j=1:Nlocs

	ilon = Ilon(j); ilat = Ilat(j);			%	 coordinate indices
		
		% allocating for E, F and m at locations $i
	tmpE = squeeze(E(:,ilat,ilon));
	tmpF = squeeze(F(:,ilat,ilon));
	tmpm = squeeze(m(:,ilat,ilon));

		% likewise for clim. averages
	tmpEbar = squeeze(Ebar(:,ilat,ilon));
	tmpFbar = squeeze(Fbar(:,ilat,ilon));
	tmpmbar = squeeze(mbar(:,ilat,ilon));
	
		% "e"
	Z = L*tmpE./(tmpF.*tmpm);
	Zbar = L*tmpEbar./(tmpFbar.*tmpmbar);

		% make unitless by *mbarbar
%	Z = nanmean(tmpmbar)*Z;
%	Zbar = nanmean(tmpmbar)*Zbar;

		% cheeky move to ts_plot work
	sig_Z = squeeze(sig_E(:,ilat,ilon));	% could be any variable

	name = ['ts', num2str(j) '_LE-Fm'];
	
	[min(Z),nanmean(Z),max(Z)]

	col = [0.323,0.12,0.978];

	ts_plot(Z,Zbar,sig_Z,Nyear,col,name);
	bins = [min(Z):1e-5:max(Z)];
	axisval = [bins(1),bins(end),0,2e4];
	if j==7; bins=[min(Z):0.5e-5:max(Z)]; 
					 axisval = [bins(1),bins(end),0,5e5];	end
	plot_hist(Z,bins,90,'',['hist_',name],axisval);

end
% ======================================================================

%% Time series of e' = L*EE/(Fbar*mm+FF*mbar) 

for j=1:Nlocs

	ilon = Ilon(j); ilat = Ilat(j);			%	 coordinate indices
		
		% clim. averages (same annual cycle for both m and F)
	tmpFbar = nanmean(squeeze(Fbar(:,ilat,ilon)));
	tmpmbar = nanmean(squeeze(mbar(:,ilat,ilon)));

		% same but for anomalies
	tmpEE = squeeze(EE(:,ilat,ilon));
	tmpFF = squeeze(FF(:,ilat,ilon));
	tmpmm = squeeze(mm(:,ilat,ilon));

	ZZ = L*tmpEE./(tmpmbar.*tmpFF + tmpmm.*tmpFbar);
	sig_Z = sqrt(Ntime/(Ntime-1)*anomaly(ZZ.*ZZ,Nyear));
		
	name = ['ts', num2str(j) '_LE-Fm_anom'];

	[min(ZZ),nanmean(ZZ),max(ZZ)]
	
	col = fliplr([0.323,0.92,0.278]);

	ts_plot(ZZ,NaN,sig_Z,Nyear,col,name);
	bins = [min(ZZ):1e-5:max(ZZ)];
	axisval = [bins(1),bins(end),0,1e5];
	if j==7; bins=[min(ZZ):0.5e-5:max(ZZ)]; 
					 axisval = [bins(1),bins(end),0,1e5];	end
	plot_hist(Z,bins,90,'',['hist_',name],axisval);

end
% ======================================================================
