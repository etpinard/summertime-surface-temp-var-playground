%%% Plotting procedure for compare.m.
  %
	% Either plots all summer-averaged scaling ratios and/or 
	% all monthly scaling ratios.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Requires: 
%%	vars_pairs, combs_v, Ncomb_v and dens		as in compare.m
%%  cvec, color_handle, bins, yval
%%	opt_monthly (= 0 for no monthly outputs) .
%%		and opt_anom_Var.
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% If scaling ratios are based on standard deviations 

if ~strcmp(opt_anom_Var,'Var')
	opt_mean = 1;
else
	opt_mean = 0;
end
% ======================================================================

%% Retrive prefix (Var_ or sig_) from vars_pairs if the same

flag_prefix = 0;
var1 = char(vars_pairs(1));
prefix1 = var1(1:4);				% only works if prefix has exactly 4 chars

for i=2:Nvar_pairs
	var2 = char(vars_pairs(i));
	prefix2 = var2(1:4);
	if ~strcmp(prefix1,prefix2)		% if not the same, break
		flag_prefix = 1;
		break
	end
	var1 = var2;
	prefix1 = prefix1;
end

if ~flag_prefix
	prefix = prefix1;		% or prefix2, they are the same.
end
% ======================================================================

%% Plot summer-averaged scaling ratios

for i=1:Ncomb_v

		% allocating the combs_v indices
	p1 = combs_v(i,1);
	p2 = combs_v(i,2);
	var1 = char(vars_pairs(p1));
	var2 = char(vars_pairs(p2));

		% if var1 is the denominator then swap
	if dens(i)==1 
		tmp = var2;
		var2 = var1;
		var1 = tmp;
		clear tmp
	end
		
	eval(['Z =  scale_' var1 '_' var2 ';']);		

	if flag_prefix
		name = ['scale_' var1 '-' var2];
	else
		name = ['scale-' prefix var1(5:end) '-' var2(5:end)];
	end
	
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
		
			% if var1 is the denominator then permute
		if dens(i)==1 
			tmp = var2;
			var2 = var1;
			var1 = var2;
		end
	
	
		eval(['Z =  scale_' char(var1) '_' char(var2) ';']);		

		if flag_prefix
			name = ['scale_' var1(5:end) '-' var2(5:end)];
		else
			name = ['scale-' prefix var1(5:end) '-' var2(5:end)];
		end
	
		plot_monthly			% plot using plot_monthly.m
		
	end
	
end
% ======================================================================

clear var1 var2 p1 p2 prefix*
