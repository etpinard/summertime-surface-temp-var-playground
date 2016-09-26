%%% Same as evapofrac.m but using m_b (and m_f) for the soil
	% moisture variable.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , locations.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Computing and plotting the evaporation fraction ...

for i=1:Nlocs			% looping through the locations

	ilat = Ilat(i); 
	ilon = Ilon(i);		% coordinate of location $i

		% allocating for E, F and m at locations $i
	tmpE = squeeze(E(:,ilat,ilon));
	tmpF = squeeze(F(:,ilat,ilon));
	
		% using m_b
	tmpm = squeeze(m_b(:,ilat,ilon));	
	tmpmbar = xmonth(squeeze(m_bbar(:,ilat,ilon)));	
	name = ['LE-F_mb', num2str(i)];
	
	%tmpm = squeeze(m_f(:,ilat,ilon));		% using m_f
	%name = ['LE-F_mf', num2str(i)];			% a less than 10% difference

		% evaporation fraction vs (m-mbar)/mbar
	x = (tmpm - tmpmbar)./tmpmbar;
	z = (L*tmpE)./tmpF;
	note = ['mbar = ',num2str(nanmean(tmpmbar))];
	scatter_plot(x,z,Nyear,[-0.1,0.1],[0,0.3],name,note);

		% or straight up againt m
	%scatter_plot(tmpm,z,Nyear,[400,1200],[0,0.3],name);

end
% ======================================================================
