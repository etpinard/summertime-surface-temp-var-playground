%%% Plotting procedure for compare_min.m.
  %
	% Either plots all summer-averaged scaling ratios and/or 
	% all monthly scaling ratios.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Requires: 
%%	var_small , vars_big			as in compare_min.m
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

	%%% NOT sure how to get this to work ...

%{
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
%}
% ======================================================================

%% Plot summer-averaged scaling ratios

	% set the output variable name
scale_string = ['scale_min_' char(var_small) '_'];
name = ['scale_min_' char(var_small) '-'];
for i=1:Nvar_big 
	scale_string = [scale_string , char(vars_big(i))];
	name = [name , char(vars_big(i))];
end
		
eval(['Z = ' scale_string ';']);		

Z(1021) = 1e5;			% cheeky move to make the color map work!
plot_summeravg			% plot using plot_summeravg.m
% ======================================================================

if opt_monthly 

		% set the output variable name
	scale_string = ['scale_min_' char(var_small) '_'];
	name = ['scale_min_' char(var_small) '-'];
	for i=1:Nvar_big 
		scale_string = [scale_string , char(vars_big(i))];
		name = [name , char(vars_big(i))];
	end
			
	eval(['Z = ' scale_string ';']);		
	
	Z(1021) = 1e5;			% cheeky move to make the color map work!
	plot_monthly			% plot using plot_monthly.m
	
end
% ======================================================================

clear scale_string
