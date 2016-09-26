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
%%	var_before, vars_after and Nvar_after as in regrs_single.m
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

for i=1:Nvar_after
		
	eval(['Z =  Res_' ...
				char(var_before) char(vars_after(i)) ';']);		
	name = ['Res_' char(var_before) '-' char(vars_after(i))];
	
	Z(1) = 1e5;			% cheeky move to make the color map work!
	plot_summeravg			% plot using plot_summeravg.m

end

% ======================================================================


%% Plot monthly correlations	(if wanted)

if opt_monthly 

		% Instantaneous
	for i=1:Nvar_after	
			
		eval(['Z =  Res_' ...
					char(var_before) char(vars_after(i)) ';']);
		name = ['Res_' char(var_before) '-' char(vars_after(i))];
	
		plot_monthly			% plot using plot_monthly.m
		
	end
	
end
% ======================================================================
