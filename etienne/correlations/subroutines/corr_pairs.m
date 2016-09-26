%%% Procedure which facilitates the computation of several 
	% correlations simultaneously for a set a variables.
	% 
	% Here, variable looping is based on possible pairs of variable,
	% determined by combinatorics.
	% e.g. To Analyze the linear relationships between forcing functions.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%%
%% Requires: vars_pairs , opt_corlag
%%	 and that the anomaly field (XX) as well as the stand. dev. (sig_X)
%%	 of all variables in vars_pars be defined.
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% length of vars_pairs (Now here!!)
Nvar_pairs = length(vars_pairs);

%% Finding the possible variable pairs

tmp = [1:Nvar_pairs];										
pairs_v = combntns(tmp,2);				 % using combinatorics
Npair_v = length(pairs_v(:,1)); 
clear tmp
	
	% CAUTION! Nvar_pairs refers to the (initial) set of variables.
	%					 Npairs_v refers to the set of variable pairs.
% ======================================================================

for i=1:Npair_v

		% allocating the pairs_v indices
	p1 = pairs_v(i,1);
	p2 = pairs_v(i,2);

		% allocating var_pairs of indices p1 and p2
	var1 = vars_pairs(p1);
	var2 = vars_pairs(p2);
	
		% allocating the two variables to correlate and their std's
	eval(['XX = ' char(var1) char(var1) ';']);
	eval(['sig_X = sig_' char(var1) ';']);
	eval(['YY = ' char(var2) char(var2) ';']);
	eval(['sig_Y = sig_' char(var2) ';']);
		
		% instantaneous correlations using corr_inst.m
	cor_string = ['cor_' char(var1) char(var2)];
	Cor_string = ['Cor_' char(var1) char(var2)];
	
	if ~exist(cor_string) || ~exist(Cor_string);
		disp(['Computing ... ' cor_string ' and ' Cor_string]);
	
		[tmp_cor,tmp_Cor] = corr_inst(XX,YY,sig_X,sig_Y);

		eval([cor_string '= tmp_cor;']);
		eval([Cor_string '= tmp_Cor;']);
	end
		
		% sometime lagged correlations are not needed
	if opt_corlag
			
			% lagged correlation with X leading using corr_lag.m
		cor_string = ['corlag_' char(var1) char(var2)];
		Cor_string = ['Corlag_' char(var1) char(var2)];
		
		if ~exist(cor_string) || ~exist(Cor_string);
			disp(['Computing ... ' cor_string ' and ' Cor_string]);
	
			[tmp_cor,tmp_Cor,pairs_m] = corr_lag(XX,YY,sig_X,sig_Y);
	
			eval([cor_string '= tmp_cor;']);
			eval([Cor_string '= tmp_Cor;']);
		end
		
			% lagged correlation with Y leading using corr_lag.m
		cor_string = ['corlag_' char(var2) char(var1)];
		Cor_string = ['Corlag_' char(var2) char(var1)];
		
		if ~exist(cor_string) || ~exist(Cor_string);
			disp(['Computing ... ' cor_string ' and ' Cor_string]);
	
			[tmp_cor,tmp_Cor] = corr_lag(YY,XX,sig_Y,sig_X);
	
			eval([cor_string '= tmp_cor;']);
			eval([Cor_string '= tmp_Cor;']);
		end

	end

end; clear cor_string Cor_string tmp_cor tmp_Cor XX YY sig_X sig_Y
% ======================================================================
