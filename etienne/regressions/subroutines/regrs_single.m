%%% Procedure that seeks to find the optimal regression for a given
	% variable. Orthogonal regressions with different possible variables
	% are performed using regrs.m. Scale analysis of the residual 
	% and the regressor is also computed.
	% 
	% Variable looping is based on an "before" (to be regressed) variable
	% and an set of "after" (regressors) variables.
	%
	% For example using anomaly notation, set 
  % 
	%		X' = X_0 + a*Y'		where a = <X',Y'>/<Y',Y'> 
	% 
	% Then, the optimal regression variable Y' will minimize the ratio
	%
	% NEW!  | sig_X_0^2 / sig_X^2 | if opt_anom_Var='Var'
	%		and | sig_X_0 / sig_X |  if not.
	%
	% Here, the (single) regressions through vars_after are computed one 
	% at a time (i.e. not successively). Use regrs_multiple.m for 
	% successive (two) regressions.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Requires: var_before, vars_after
%%	 and that the anomaly field (XX) as well as the std. (sig_X) or
%%	 Var_X of all variables in var_before or vars_after be defined.
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Now here!
Nvar_after = length(vars_after);
% ======================================================================

%% Allocating the before variable (XX and sig_X or Var_X)

eval(['XX = ' char(var_before) char(var_before) ';']);
if strcmp(opt_anom_Var,'Var');
	eval(['Var_X = Var_' char(var_before) ';']);
else
	eval(['sig_X = sig_' char(var_before) ';']);
end
% ======================================================================

%% Computing the single regressions for all "after" variables

for i=1:Nvar_after
	
		% allocation the var_after index
	var_after = vars_after(i);

		% allocating the ith "after" variable to regress with XX
	eval(['YY = ' char(var_after) char(var_after) ';']);
	if strcmp(opt_anom_Var,'Var');
		eval(['Var_Y =  Var_' char(var_after) ';']);
	else
		eval(['sig_Y =  sig_' char(var_after) ';']);
	end

		% initializing the output of regrs.m
	%a_string = ['a_' char(var_before) char(var_after)];	% not needed!
	%res_string = ['res_' char(var_before) char(var_after)];
	
	if strcmp(opt_anom_Var,'Var')
		mag_res_string = ['Var_res_' char(var_before) char(var_after)];
	else
		mag_res_string = ['sig_res_' char(var_before) char(var_after)];
	end
		
		% 1) computing the regression using regrs.m
	%if ~exist(a_string) || ~exist(res_string) || ~exist(sig_res_string)
	
	if ~exist(mag_res_string)

		disp(['Computing ... ' mag_res_string]);
	
			% first the regression
		[tmp_a,tmp_res] = regrs(XX,YY);

			% second the residual magnitude
		if strcmp(opt_anom_Var,'Var')
			tmp_mag_res = anomaly_Var(tmp_res);
		else
			tmp_mag_res = anomaly_sig(tmp_res);
		end

%		eval([a_string '= tmp_a;']);
%		eval([res_string '= tmp_res;']);

		eval([mag_res_string '= tmp_mag_res;']);
	
	end

		%% It is reasonable to consider lagged regressions?
		%% If so add an "if opt_regrslag block" as in the 
		%% correlations subroutines.
		
		% 2) computing the ratios of the residual to minimize
	Res_string = ['Res_' char(var_before) char(var_after)];
	
	if ~exist(Res_string)

		disp(['Computing ... ' Res_string]);
		
		%eval(['tmp_a =' a_string ';']);
		%eval(['tmp_sig_res =' sig_res_string ';']);
		%tmp_ratio = abs(tmp_sig_res./(tmp_a.*sig_Y));
		
			% in case it is already computed
		eval(['tmp_mag_res =' mag_res_string ';']);

		if strcmp(opt_anom_Var,'Var')
			%tmp_Res = abs(tmp_mag_res./Var_X);
			tmp_Res = sqmean(abs(tmp_mag_res./Var_X));
		else
			tmp_Res = abs(tmp_mag_res./sig_X);
		end

		eval([Res_string '= tmp_Res;']);

	end

end

clear tmp_* XX YY sig_X sig_Y Var_X Var_Y
%clear a_string res_string sig_res_string ratio_string
clear Res_string mag_res_string
% ======================================================================
