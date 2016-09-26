%%% Plotting procedure for corr_pairs.m.
  %
	% Either plots all summer average correlations and/or 
	% all monthly correlations.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Requires: 
%%	vars_pairs, Nvar_pairs  as in corr_pairs.m
%%	opt_monthly (= 0 for no monthly outputs) and pairs_m.
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Plotting option (now here) , they are always the same for corr maps.
cvec = [-1:0.1:1]; 
bins = [-1:0.01:1];							
yval = 3;
color_handle = @color_corr3;		% newest variant 
% ======================================================================

%% Plot summer-averaged correlations 

	% Instantaneous
for i=1:Npair_v
	
		% allocations for variables of $pairs_v(i)
	p1 = pairs_v(i,1);
	p2 = pairs_v(i,2);
	var1 = vars_pairs(p1);
	var2 = vars_pairs(p2);
		
	eval(['Z =  Cor_' ...
				char(var1) char(var2) ';']);		% 2D already
	name = ['cor_' char(var1) char(var2)];
	
	plot_summeravg			% plot using plot_summeravg.m

end

	% sometimes lagged correlations are not useful
if opt_corlag

		% Lag 1 month
	for i=1:Npair_v
			
			% allocations for variables of $pairs_v(i)
		p1 = pairs_v(i,1);
		p2 = pairs_v(i,2);
		var1 = vars_pairs(p1);
		var2 = vars_pairs(p2);
			
		eval(['Z =  Corlag_' ...		% var1 leading
					char(var1) char(var2) ';']);	
		Z = sqz(Z(1,:,:));	% 2D
		name = ['corlag1_' char(var1) char(var2)];
		
		plot_summeravg			% plot using plot_summeravg.m
	
		eval(['Z =  Corlag_' ...		% var2 leading
					 char(var2) char(var1) ';']);	
		Z = sqz(Z(1,:,:));	% 2D
		name = ['corlag1_' char(var2) char(var1)];
		
		plot_summeravg			% plot using plot_summeravg.m
	
	end
	
		% lag 2 month
	for i=1:Npair_v			
			
			% allocations for variables of $pairs_v(i)
		p1 = pairs_v(i,1);
		p2 = pairs_v(i,2);
		var1 = vars_pairs(p1);
		var2 = vars_pairs(p2);
	
		eval(['Z =  Corlag_' ...		% var1 leading
					char(var1) char(var2) ';']);	
		Z = sqz(Z(2,:,:));	% 2D
		name = ['corlag2_' char(var1) char(var2)];
	
		plot_summeravg			% plot using plot_summeravg.m
	
		eval(['Z =  Corlag_' ...		% var2 leading
					 char(var2) char(var1) ';']);	
		Z = sqz(Z(2,:,:));	% 2D
		name = ['corlag2_' char(var2) char(var1)];
		
		plot_summeravg			% plot using plot_summeravg.m
	
	end

end
	%% Make more general, to include cases where
	%% Corlag is not (2 x Nlat x Nlon).

	%% Alos, maybe add in a opt_summeravg

% ======================================================================


% Plot monthly correlations	(if wanted)

if opt_monthly 

		% Instantaneous
	for i=1:Npair_v
		
			% allocations for variables of $pairs_v(i)
		p1 = pairs_v(i,1);
		p2 = pairs_v(i,2);
		var1 = vars_pairs(p1);
		var2 = vars_pairs(p2);
			
		eval(['Z =  cor_' ...
					char(var1) char(var2) ';']);
		name = ['cor_' char(var1) char(var2)];
	
		plot_monthly			% plot using plot_monthly.m
		
	end

		% var1 leading  
	for i=1:Npair_v
			
			% allocations for variables of $pairs_v(i)
		p1 = pairs_v(i,1);
		p2 = pairs_v(i,2);
		var1 = vars_pairs(p1);
		var2 = vars_pairs(p2);
		
		for it=1:Nmonth 

			eval(['Z =  corlag_' ...
						char(var1) char(var2) ';']);
			name = ['cor_' char(var1) num2str(pairs_m(it,1)) ...
										 char(var2) num2str(pairs_m(it,2))];
			
			Z = sqz(Z(it,:,:));			% 2D

			plot_summeravg			% plot using plot_summeravg.m
	
		end
	
	end
		
		% var2 leading  
	for i=1:Npair_v
		
		for it=1:Nmonth 

			eval(['Z =  corlag_' ...
						char(var2) char(var1) ';']);
			name = ['cor_' char(var2) num2str(pairs_m(it,1)) ...
										 char(var1) num2str(pairs_m(it,2))];
			
			Z = sqz(Z(it,:,:));			% 2D

			plot_summeravg			% plot using plot_summeravg.m
	
		end
	
	end

end
	
	%% Make more general, to include cases where
	%% corlag is not (Nmonth x Nlat x Nlon).
	%% e.g. if Nmonth = 4.

% ======================================================================
