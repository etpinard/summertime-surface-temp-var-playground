%%% Programme that compares various ways of computing "e" and "r"
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Computing and plotting "r" using means

factor_r = 1e3;

nogood = find(Pbar*secinday < 0.1);
Pbar(nogood) = NaN;
Z = Rbar./(mbar.*Pbar);

for it=1:Nmonth

	name = ['r_means',num2str(it)];
	
	z = squeeze(Z(it,:,:))*factor_r;

	tmp = reshape(z,Nlat*Nlon,1);
	[min(tmp),max(tmp),nanmean(tmp)]
	
	cvec = [0:0.2:4];
	bins = [0:0.01:5];
	axisval = [bins(1),bins(end),0,2.5];
	
	plot_map_miller(lon,lat,z,cvec,name);
	plot_hist(z,bins,Nland,'',['hist_',name],axisval);

end
% ======================================================================

%% Computing and plotting "r" using variances and covariances

cov_Rm = Nyear/(Nyear-1)*anomaly(RR.*mm,Nyear);
cov_RP = Nyear/(Nyear-1)*anomaly(RR.*PP,Nyear);
cov_mP = Pbar.*cov_Rm+mbar.*cov_RP;
nogood = find(abs(cov_mP)*secinday<1e-5);
cov_mP(nogood) = NaN;
Z = sig_R.^2./cov_mP;

for it=1:Nmonth

	name = ['r_var',num2str(it)];

	z = squeeze(Z(it,:,:))*factor_r;

	tmp = reshape(z,Nlat*Nlon,1);
	[min(tmp),max(tmp),nanmean(tmp)]
	
	cvec = [-0.2:0.05:0.2];
	bins = [-0.5:0.005:0.5];
	axisval = [bins(1),bins(end),0,100];
	
	plot_map_miller(lon,lat,z,cvec,name);
	plot_hist(z,bins,Nland,'',['hist_',name],axisval);

end
% ======================================================================

%% Computing and plotting "e" using means

factor_e = 1e10;

Z = Ebar./(mbar.*Fbar);

for it=1:Nmonth

	name = ['e_means',num2str(it)];
	
	z = squeeze(Z(it,:,:))*factor_e;

	tmp = reshape(z,Nlat*Nlon,1);
	[min(tmp),max(tmp),nanmean(tmp)]
	
	cvec = [0:0.2:4];
	bins = [0:0.01:5];
	axisval = [bins(1),bins(end),0,2.5];
	
	plot_map_miller(lon,lat,z,cvec,name);
	plot_hist(z,bins,Nland,'',['hist_',name],axisval);

end
% ======================================================================

%% Computing and plotting "e" using variances and covariances

cov_Em = Nyear/(Nyear-1)*anomaly(EE.*mm,Nyear);
cov_EF = Nyear/(Nyear-1)*anomaly(EE.*FF,Nyear);
cov_mF = Fbar.*cov_Em+mbar.*cov_EF;
nogood = find(abs(cov_mF)<1e-5);
cov_mF(nogood) = NaN;
Z = sig_E.^2./cov_mF;

for it=1:Nmonth

	name = ['e_var',num2str(it)];

	z = squeeze(Z(it,:,:))*factor_e;

	tmp = reshape(z,Nlat*Nlon,1);
	[min(tmp),max(tmp),nanmean(tmp)]
	
	cvec = [-0.2:0.05:0.2];
	bins = [-0.5:0.005:0.5];
	axisval = [bins(1),bins(end),0,100];
	
	plot_map_miller(lon,lat,z,cvec,name);
	plot_hist(z,bins,Nland,'',['hist_',name],axisval);

end
% ======================================================================
