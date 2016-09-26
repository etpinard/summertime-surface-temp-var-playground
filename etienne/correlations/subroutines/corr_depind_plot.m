%%% Plotting procedure for corr_depind.m.
  %
	% Either plots all summer average correlations and/or 
	% all monthly correlations.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Requires: 
%%	var_dep, vars_ind		 as in corr_depind.m
%%	opt_monthly (= 0 for no monthly outputs) and pairs_m.
%%	(optional) opt_overlay (=1 for mbarbar overlay contour)
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Plotting option (now here) , they are always the same for corr maps.
%cvec = [[-1:0.1:-0.3],0,[0.3:0.1:1]];
cvec = [-1:0.1:1];
bins = [-1:0.01:1];							
yval = 3;
%color_handle = @color_corr_nl;	% newest variant --- Non-linear baby!
color_handle = @color_corr4;
% ======================================================================

%% Computed here now
Nvar_ind = length(vars_ind);

%% Plot summer-averaged correlations 

	% Instantaneous
for i=1:Nvar_ind
		
	eval(['Z =  Cor_' ...
				char(var_dep) char(vars_ind(i)) ';']);		% 2D already
	name = ['cor_' char(var_dep) char(vars_ind(i))];
	
	plot_summeravg			% plot using plot_summeravg.m

end

	% sometimes lagged correlations are not useful
if opt_corlag
	
		% Lag 1 month
	for i=1:Nvar_ind			
			
		eval(['Z =  Corlag_' ...		% var_dep leading
					char(var_dep) char(vars_ind(i)) ';']);	
		Z = sqz(Z(1,:,:));	% 2D
		name = ['corlag1_' char(var_dep) char(vars_ind(i))];
		
		plot_summeravg			% plot using plot_summeravg.m
	
		eval(['Z =  Corlag_' ...		% var_indep leading
					 char(vars_ind(i)) char(var_dep) ';']);	
		Z = sqz(Z(1,:,:));	% 2D
		name = ['corlag1_' char(vars_ind(i)) char(var_dep)];
		
		plot_summeravg			% plot using plot_summeravg.m
	
	end
	
		% lag 2 month
	for i=1:Nvar_ind			
			
		eval(['Z =  Corlag_' ...		% var_dep leading
					char(var_dep) char(vars_ind(i)) ';']);	
		Z = sqz(Z(2,:,:));	% 2D
		name = ['corlag2_' char(var_dep) char(vars_ind(i))];
	
		plot_summeravg			% plot using plot_summeravg.m
	
		eval(['Z =  Corlag_' ...		% var_indep leading
					 char(vars_ind(i)) char(var_dep) ';']);	
		Z = sqz(Z(2,:,:));	% 2D
		name = ['corlag2_' char(vars_ind(i)) char(var_dep)];
		
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
	for i=1:Nvar_ind	
			
		eval(['Z =  cor_' ...
					char(var_dep) char(vars_ind(i)) ';']);
		name = ['cor_' char(var_dep) char(vars_ind(i))];
	
		plot_monthly			% plot using plot_monthly.m
		
	end
	
		% sometimes lagged correlations are not useful
	if opt_corlag
	
			% var_dep leading  
		for i=1:Nvar_ind	
			
			for it=1:Nmonth 
	
				eval(['Z =  corlag_' ...
							char(var_dep) char(vars_ind(i)) ';']);
				name = ['cor_' char(var_dep) num2str(pairs_m(it,1)) ...
											 char(vars_ind(i)) num2str(pairs_m(it,2))];
				
				Z = sqz(Z(it,:,:));			% 2D
	
				plot_summeravg			% plot using plot_summeravg.m
		
			end
		
		end
			
			% var_ind leading  
		for i=1:Nvar_ind	
			
			for it=1:Nmonth 
	
				eval(['Z =  corlag_' ...
							char(vars_ind(i)) char(var_dep) ';']);
				name = ['cor_' char(vars_ind(i)) num2str(pairs_m(it,1)) ...
											 char(var_dep) num2str(pairs_m(it,2))];
				
				Z = sqz(Z(it,:,:));			% 2D
	
				plot_summeravg			% plot using plot_summeravg.m
		
			end
		
		end
	
	end

end
	
	%% Make more general, to include cases where
	%% corlag is not (Nmonth x Nlat x Nlon).
	%% e.g. if Nmonth = 4.

% ======================================================================
