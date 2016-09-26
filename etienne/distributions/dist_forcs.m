%%% Compute and plots sigma_gamma, sigma_psi and R_gampsi
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% Computing full-summer statistics (for now)
 
	% standard deviation of gamma
%sig_gam = sqrt(squeeze(nanmean(gamma.*gamma)));
[junk1,junk2,sig_gam] = anomaly(gamma,Nyear);

	% standard deviation of psi
%sig_psi = sqrt(squeeze(nanmean(psi.*psi)));
[junk1,junk2,sig_psi] = anomaly(psi,Nyear);

clear junk1 junk2

	% covariance of gamma and psi
Rgampsi = squeeze(nanmean(gamma.*psi));
% ======================================================================

%% Plotting the results

for i=1:Nmonth
	% 1) sig_gam
name = ['sig_gam',num2str(i)];
z = squeeze(sig_gam(i,:,:));
cvec = [0:4:32];
tmp = reshape(z,Nlat*Nlon,1);
[min(tmp),max(tmp),nanmean(tmp)]
bins = [0:1:50];
axisval = [bins(1),bins(end),0,0.1];

plot_map_miller(lon,lat,z,cvec,name);
plot_hist(z,bins,Nland,'',['hist_',name],axisval);
end

for i=1:Nmonth
	% 2) sig_psi
name = ['sig_psi',num2str(i)];
z = squeeze(sig_psi(i,:,:))*secinday;
tmp = reshape(z,Nlat*Nlon,1);
[min(tmp),max(tmp),nanmean(tmp)]
cvec = [0:0.2:2.4];
bins = [0:0.1:3];
axisval = [bins(1),bins(end),0,1.5];

plot_map_miller(lon,lat,z,cvec,name);
plot_hist(z,bins,Nland,'',['hist_',name],axisval);
end

	% 3) sig_psi
name = 'R_gampsi';
z = Rgampsi*secinday;
tmp = reshape(z,Nlat*Nlon,1);
[min(tmp),max(tmp),nanmean(tmp)]
cvec = [-30:5:0];
bins = [-30:0.5:5];
axisval = [bins(1),bins(end),0,0.15];

plot_map_miller(lon,lat,z,cvec,name);
plot_hist(z,bins,Nland,'',['hist_',name],axisval);
% ======================================================================

%% Plotting lambda 
name = 'lambda';
z = lambda;
tmp = reshape(z,Nlat*Nlon,1);
[min(tmp),max(tmp),nanmean(tmp)]
cvec = [0:0.02:0.3];
bins = [-0.005:0.005:0.5];
axisval = [bins(1),bins(end),0,10];

plot_map_miller(lon,lat,z,cvec,name);
plot_hist(z,bins,Nland,'',['hist_',name],axisval);
% ======================================================================

%% Plotting alpha 
name = 'alpha';
z = alpha./L;
tmp = reshape(z,Nlat*Nlon,1);
[min(tmp),max(tmp),nanmean(tmp)]

cvec = [-1:0.1:0.2];
bins = [-1.5:0.01:0.5];
axisval = [bins(1),bins(end),0,2.5];

plot_map_miller(lon,lat,z,cvec,name);
plot_hist(z,bins,Nland,'',['hist_',name],axisval);
% ======================================================================

%% Plotting alpha over beta 
name = 'alpha_over_beta';
z = abs(alpha./beta);
tmp = reshape(z,Nlat*Nlon,1);
[min(tmp),max(tmp),nanmean(tmp)]

cvec = [0:0.02:0.2];
bins = [0:0.01:0.5];
axisval = [bins(1),bins(end),0,20];

plot_map_miller(lon,lat,z,cvec,name);
plot_hist(z,bins,Nland,'',['hist_',name],axisval);
% ======================================================================
