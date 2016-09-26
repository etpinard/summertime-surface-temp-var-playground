%%% The plotting procedure for ts_corr.m

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , locations.m , ts_corr.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

% 1) Plot instantaneous monthly results 
for i=1:Npair_v			% looping through the possible variable pairs
		
		% copying the variables  (NOTE now "corr_ ...")
	eval(['Z =  corr_' ...
				char(vars(pair_v(i,1))) char(vars(pair_v(i,2))) ';']);

	for j=1:Nlocs					% looping through the locations
		
		z = squeeze(Z(:,j));		% now 1D

				% name for output
		name = ['corr' num2str(j) '_' char(vars(pair_v(i,1))) ...
							char(vars(pair_v(i,2)))];

			% plotting z
		ts_plot2(z,Nyear,'k',name);	
			% plotting a histogram of z
		bins = [min(z):0.2:max(z)];
		plot_hist(z,bins,Ntime,'',['hist_',name]);
		
	end
end
% ======================================================================

% 2) Plot lag correlations of the same variable 
for i=1:2					% looping through the variables (just 2 for now)
	for j=1:Npair_m				% looping through the summer months
		
		eval(['Z =  corr_' ...
					char(vars(i)) num2str(pair_m(j,1)) num2str(pair_m(j,2)) ';']);
	
		for k=1:Nlocs					% looping through the locations
			
			z = squeeze(Z(:,k));		% now 1D

					% name for output
			name = ['corr' num2str(k) '_'  ...
					char(vars(i)) num2str(pair_m(j,1)) num2str(pair_m(j,2))];

				% plotting z
			ts_plot2(z,Nyear,'b',name);	
				% plotting a histogram of z
			bins = [min(z):0.5:max(z)];
			plot_hist(z,bins,Nyear,'',['hist_',name]);
			
		end
	end
end
% ======================================================================

% 3) Plot lag correlations of paired variables 
for i=1:Npair_v			% looping through the possible variable pairs
	for j=1:Npair_m				% looping through the summer months
		
		eval(['Z = corr_' char(vars(pair_v(i,1))) num2str(pair_m(j,1)) ...
									char(vars(pair_v(i,2))) num2str(pair_m(j,2)) ';']);

		for k=1:Nlocs					% looping through the locations
			
			z = squeeze(Z(:,k));		% now 1D

					% name for output
			name = ['corr' num2str(k) '_'  ...
								char(vars(pair_v(i,1))) num2str(pair_m(j,1)) ...
									char(vars(pair_v(i,2))) num2str(pair_m(j,2))];

				% plotting z
			ts_plot2(z,Nyear,'g',name);	
				% plotting a histogram of z
			bins = [min(z):0.5:max(z)];
			plot_hist(z,bins,Nyear,'',['hist_',name]);
			
		end
	end

	for j=1:Npair_m				% looping through the summer months (2nd loop)
		
		eval(['Z = cor_' char(vars(pair_v(i,1))) num2str(pair_m(j,2)) ...
									char(vars(pair_v(i,2))) num2str(pair_m(j,1)) ';']);

		for k=1:Nlocs					% looping through the locations
			
			z = squeeze(Z(:,k));		% now 1D

					% name for output
			name = ['corr' num2str(k) '_'  ...
								char(vars(pair_v(i,1))) num2str(pair_m(j,2)) ...
									char(vars(pair_v(i,2))) num2str(pair_m(j,1))];

				% plotting z
			ts_plot2(z,Nyear,'g',name);	
				% plotting a histogram of z
			bins = [min(z):0.5:max(z)];
			plot_hist(z,bins,Nyear,'',['hist_',name]);
			
		end
	end
end
% ======================================================================

