%%% Plotting procedure for regrs_single.m.
  %
	% Either plots all summer average regression ratio (see
	% regrs_single.m for explanations) and/or 
	% all monthly regressions ratios.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Requires: 
%%	var_before, vars_after and Npair_v as in regrs_multiple.m
%%  cvec, color_handle, bins, yval
%%	opt_monthly (= 0 for no monthly outputs) .
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% If residual ratios are based on std use opt_mean (see
 % plot_summeravg.m for more info) 

if strcmp(opt_anom_Var,'Var')
	opt_mean = 0;
else
	opt_mean = 1;
end
% ======================================================================

%% Plot summer-averaged correlations 

for i=1:Npair_v

		% allocating the pairs_v indices
	p1 = pairs_v(i,1);
	p2 = pairs_v(i,2);
	var1 = vars_after(p1);
	var2 = vars_after(p2);
		
	eval(['Z =  Res_' ...
				char(var_before) char(var1) char(var2) ';']);		
	name = ['Res_' char(var_before) '-' char(var1) char(var2)];
	
	Z(1021) = 1e5;			% cheeky move to make the color map work!
	plot_summeravg			% plot using plot_summeravg.m

end

% ======================================================================


%% Plot monthly correlations	(if wanted)

if opt_monthly 

	for i=1:Npair_v
		
			% allocating the pairs_v indices
		p1 = pairs_v(i,1);
		p2 = pairs_v(i,2);
		var1 = vars_after(p1);
		var2 = vars_after(p2);
				
		eval(['Z =  Res_' ...
					char(var_before) char(var1) char(var2) ';']);
		name = ['Res_' char(var_before) '-' char(var1) char(var2)];
	
		plot_monthly			% plot using plot_monthly.m
		
	end
	
end
% ======================================================================
