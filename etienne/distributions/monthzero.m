%%% Loads month-zero values from NetCDF files computes 
	% ratios with respect to the summer-mean values.
	% Implemented for soil moisture only for now.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Load data, month zero only, remove high lats, trims.
	
	% path to data files
datapath = ['/home/disk/p/etienne/proj/data/',model_name,'/'];
	
	% path to NetCDF file
%path = [datapath,'mrso.cdf'];
path = [datapath,'mrsos.cdf'];
	
	% -) loads "soil moisture of the surface layer" of the CCSM3
%m0 = nc_varget(path,'mrso');			% not the same in GFDL 2.1
m0 = nc_varget(path,'mrsos');			% not the same in GFDL 2.1

	% -) month zero : May in NH, and November in SH
m0 = summer_only(m0,5,5,Nyear);		% 5 for May 

	% no need to remove data over non-land (it is the moisture variable
	% after all).

	% -) removing high lats to be consistent with plot_map_miller.m
max_NH = 77;max_SH = -55;		
notgood = find(lat>max_NH); m0(:,notgood,:) = NaN;
notgood = find(lat<max_SH); m0(:,notgood,:) = NaN;

	% -) Trimming with trim.m
m0 = trim(m0,mbar,m_range);
% ======================================================================a

%% Computes the ratio of month-zero soil moisture to the summer mean.
 % The $Nyear values are then averaged for a climatological mean.

	% Reshaping so that the first dimension has the summer months 
m_summer = reshape(m,Nmonth,Nyear,Nlat,Nlon);
	
	% Averaging over the summer months
m_summer = squeeze(nanmean(m_summer));
	
	% Taking the ratio with the month zero
ratio = m0./m_summer;

	% The climatological mean
z = squeeze(nanmean(ratio));

% Plotting the result 
name = 'month0_m';
cvec = [0:0.005:0.05];
bins = [0:1e-3:0.1];
plot_map_miller(lon,lat,z,cvec,name);	
plot_hist(z,bins,Nland,'',['hist_',name],[0,1,0,2]);
% ======================================================================

%% Same but with sigma_X  (Not the exact std ... you know)

	% Same as in dist_plot.m (use factor to make unbias)

	% A huge overestimate of the typical anomalies in m
%fact = 1;				
%sig_m_summer = sqrt(squeeze(fact*nanmean(m.^2)));	

sig_m_summer = squeeze(min(sig_m));		
%sig_m_summer = squeeze(nanmean(sig_m));		

	% remove vanishing denominator
notgood = find(sig_m_summer == 0);
sig_m_summer(notgood) = NaN;

	% Taking the standard deviation of month zero
sig_m0 = squeeze(nanstd(m0));

	% The ratio 
z = sig_m0./sig_m_summer;

% Plotting the result 
name = 'month0_mm';
cvec = [0:0.2:2];
bins = [0:0.01:0.25];
plot_map_miller(lon,lat,z,cvec,name);	
plot_hist(z,bins,Nland,'',['hist_',name],[0,3,0,2]);
% ======================================================================
