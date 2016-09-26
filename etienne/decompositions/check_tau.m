%%% MATLAB program for everything tau and tau_s
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Compute and plot the ratio sig_H0 to kappa*sig_T 

% Compute sig_H0 using anomaly.m
sig_H0 = sqrt(Nyear/(Nyear-1)*anomaly(HH0.*HH0,Nyear));

for it=1:Nmonth		% looping through the summer months
	
		% squeezing at month $i
	sig_H01 = squeeze(sig_H0(it,:,:));
	sig_T1 = squeeze(sig_T(it,:,:));
	kappa1 = squeeze(kappa(it,:,:));

	name = ['ratio_sig_H0_T',num2str(it)];
	
		% taking the ratio sig_R
	z = abs(sig_H01./(kappa1.*sig_T1));
	nogood = find(z>1e2); z(nogood) = NaN;
		
		% plotting the ratio
	cvec = [0:0.2:4];
	bins = [0:0.1:7];
	axisval = [bins(1),bins(end),0,1.5];
	plot_map_miller(lon,lat,z,cvec,name);	
	plot_hist(z,bins,Nland,'',['hist_',name],axisval);
	
end; clear sig_H01 sig_T1 kappa1 
% ======================================================================

break

%% Compute and plot the ratio sig_H0 to U'/tau

% Compute sig_H0 using anomaly.m
sig_H0 = sqrt(Nyear/(Nyear-1)*anomaly(HH0.*HH0,Nyear));

for it=1:Nmonth		% looping through the summer months
	
		% squeezing at month $i
	sig_H01 = squeeze(sig_H0(it,:,:));
	sig_U1 = C_p*squeeze(sig_T(it,:,:));
	tau1 = squeeze(tau(it,:,:));

	name = ['ratio_sig_H0_U',num2str(it)];
	
		% taking the ratio sig_R
	z = tau1.*abs(sig_H01./sig_U1);
	nogood = find(z>1e2); z(nogood) = NaN;
		
		% plotting the ratio
	cvec = [0:0.2:4];
	bins = [0:0.1:7];
	axisval = [bins(1),bins(end),0,1.5];
	plot_map_miller(lon,lat,z,cvec,name);	
	plot_hist(z,bins,Nland,'',['hist_',name],axisval);
	
end; clear sig_H01 sig_U1 tau1 
% ======================================================================
