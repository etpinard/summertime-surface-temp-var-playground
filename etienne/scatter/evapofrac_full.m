%%% Computing and plotting the evaporation fraction
	% as a function of soil moisture for the whole globe.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Computing L*Ebar/Fbar as a function of mbar for summer

	% computing full summer averages
Ebarbar = squeeze(nanmean(Ebar));
Fbarbar = squeeze(nanmean(Fbar));
mbarbar = squeeze(nanmean(mbar));

	% computing the evaporative fraction
Y = (L*Ebarbar)./Fbarbar;
X = mbarbar;

	% computing the summer-mean standard deviation
fact = 3*(Nyear-1)/(3*Nyear-1);			
z = sqrt(squeeze(fact*nanmean(sig_T.^2)));	
Z =	nanmean(reshape(z,Nlat*Nlon,1));

	% finding the indices within muZ \pm sigZ
i1 = find(z<=0.5*Z); ii1 = find(z>0.5*Z); 
	% finding the indices within muZ \pm 2*sigZ
i2 = find(z(ii1)<=Z); ii2 = find(z(ii1)>Z);
	% finding the indices within muZ \pm 3*sigZ
i3 = find(z(ii2)<=1.5*Z); i4 = find(z(ii2)>1.5*Z);

	% plotting 
name = 'evapofrac_bar_full';
evapofrac_full_plot(X(i1),Y(i1),[0,55],[-0.02,0.4],'b',[name,'1']);
evapofrac_full_plot(X(i2),Y(i2),[0,55],[-0.02,0.4],'g',[name,'2']);
evapofrac_full_plot(X(i3),Y(i3),[0,55],[-0.02,0.4],'y',[name,'3']);
evapofrac_full_plot(X(i4),Y(i4),[0,55],[-0.02,0.4],'r',[name,'4']);
evapofrac_full_plot(X,Y,[0,55],[-0.02,0.4],'b',name);
% ======================================================================

break

%% Computing L*Ebar/Fbar as a function of mbar for each month

for it=1:Nmonth

		% squeeze at month $i
	Ebar1 = squeeze(Ebar(it,:,:));
	Fbar1 = squeeze(Fbar(it,:,:));
	mbar1 = squeeze(mbar(it,:,:));

		% computing the evaporative fraction
	Y = (L*Ebar1)./Fbar1;
	X = mbar1;
	
		% plotting
	name = ['evapofrac_bar',num2str(it)];
	evapofrac_full_plot(X,Y,[0,60],[-0.02,0.4],[],name);

end; clear Ebar1 Fbar1 mbar1
% ======================================================================

%% Computing L*E/F as a function of m, full (N*Nlat*Nlon points)

	% computing the evaporative fraction
Y = (L*E)./F;
X = m;

	% plotting 
name = 'evapofrac_full';
evapofrac_full_plot(X,Y,[0,60],[-0.02,0.4],[],name);
% ======================================================================
