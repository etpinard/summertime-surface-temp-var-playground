%%% Procedure that seeks to find the optimal regression for a given
	% variable. Succesive orthogonal regressions with different possible 
	% ordering of variables
	% are performed using regrs.m. Scale analysis of the residual 
	% and the regressor is also computed.
	% 
	% Variable looping is based on an "before" (to be regressed) variable
	% and an set of "after" (regressors) variables.
	%
	% For example using anomaly notation, set 
  % 
	%		X' = X_0' + a*Y'		where a = <X',Y'>/<Y',Y'> 
	%
	%	and then 
	%
	%		X' = X_00' + b*Z' + a*Y'	where b = <X_0',Z'>/<Z',Z'>
	%
	% This time, the optimal regression variable Y' will minimize the ratio
	%
	% NEW!  | sig_X_00^2 / sig_X^2 | if opt_anom_Var='Var'
	%		and | sig_X_00 / sig_X |  if not.
	%
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Requires: var_before, vars_after
%%	 and that the anomaly field (XX) as well as the stand. dev. (sig_X)
%%	 (or Var_X) of all variables in var_before or vars_after be defined.
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Find length of vars_after (yes now here!)
Nvar_after = length(vars_after);

%% Allocating the before variable (XX and sig_X or Var_X)

eval(['XX = ' char(var_before) char(var_before) ';']);
if strcmp(opt_anom_Var,'Var');
	eval(['Var_X = Var_' char(var_before) ';']);
else
	eval(['sig_X = sig_' char(var_before) ';']);
end
% ======================================================================

%% Finding the possible variable pairs (in both orders!)

tmp = [1:Nvar_after];										
pairs_v = [combntns(tmp,2);fliplr(combntns(tmp,2))];
Npair_v = length(pairs_v(:,1)); 
clear tmp
% ======================================================================

%% Computing the single regressions for all "after" variables

for i=1:Npair_v
		
		% allocating the pairs_v indices
	p1 = pairs_v(i,1);
	p2 = pairs_v(i,2);

		% allocating var_pairs of indices p1 and p2
	var1 = vars_after(p1);
	var2 = vars_after(p2);

		% allocating the 2 "after" variable to regress with XX
	eval(['YY = ' char(var1) char(var1) ';']);
	eval(['ZZ = ' char(var2) char(var2) ';']);
	if strcmp(opt_anom_Var,'Var');
		eval(['Var_Y = Var_' char(var1) ';']);
		eval(['Var_Z = Var_' char(var2) ';']);
	else
		eval(['sig_Y = sig_' char(var1) ';']);
		eval(['sig_Z = sig_' char(var2) ';']);
	end

	%% 1) the first regression computing a and X0X0

		% initializing the first output of regrs.m
	%a_string = ['a_' char(var_before) char(var1)];		% not needed!
	X0X0_string = ['X0X0_' char(var_before) char(var1)];
	
	if strcmp(opt_anom_Var,'Var')
		mag_res0_string = ['Var_res_' char(var_before) char(var1)];
	else
		mag_res0_string = ['sig_res_' char(var_before) char(var1)];
	end
		
		% computing the regression using regrs.m
	%if ~exist(a_string) || ~exist(X0X0_string) || ~exist(sig_X0_string)

	if ~exist(mag_res0_string) || ~exist(X0X0_string)

		disp(['Computing ... ' X0X0_string ' and ' mag_res0_string]);
	
		[tmp_a,tmp_X0X0] = regrs(XX,YY);
	
		if strcmp(opt_anom_Var,'Var')
			tmp_mag_res0 = anomaly_Var(tmp_X0X0);
		else
			tmp_mag_res0 = anomaly_sig(tmp_X0X0);
		end

		%eval([a_string '= tmp_a;']);
		eval([X0X0_string '= tmp_X0X0;']);
		eval([mag_res0_string '= tmp_mag_res0;']);
	
	else

		eval(['tmp_X0X0 = X0X0_' char(var_before) char(var1) ';']);

	end
	
	%% 2) the second regression computing b and X00X00

		% initializing the second output of regrs.m
	%b_string = ['b_' char(var_before) char(var2)];
	X00X00_string = ['X00X00_' char(var_before) char(var2)];
	if strcmp(opt_anom_Var,'Var')
		mag_res00_string = ['Var_res_' char(var_before) ...
																			char(var1) char(var2)];
	else
		mag_res00_string = ['sig_res_' char(var_before) ...
																			char(var1) char(var2)];
	end

		% computing the regression using regrs.m
	%if ~exist(b_string) || ~exist(X00X00_string) || ~exist(sig_X00_string)
	
	if ~exist(mag_res00_string)

		disp(['Computing ... ' X00X00_string ' and ' mag_res00_string]);
	
		[tmp_b,tmp_X00X00] = regrs(tmp_X0X0,ZZ);
	
		if strcmp(opt_anom_Var,'Var')
			tmp_mag_res00 = anomaly_Var(tmp_X00X00);
		else
			tmp_mag_res00 = anomaly_sig(tmp_X00X00);
		end

		%eval([b_string '= tmp_b;']);
		%eval([X00X00_string '= tmp_X00X00;']);
		eval([mag_res00_string '= tmp_mag_res00;']);
	
	end
		

		% computing the ratios to minimize (notice the ordering!!)
	Res_string = ['Res_' char(var_before) char(var1) char(var2)];
	
	if ~exist(Res_string)
		disp(['Computing ... ' Res_string]);
		
	%	eval(['tmp_a =' a_string ';']);
	%	eval(['tmp_b =' b_string ';']);
	% eval(['tmp_sig_X00 =' sig_X00_string ';']);
	%	tmp_ratio = abs(tmp_sig_X00./ ... 
	%										(tmp_b.*sig_Z + tmp_a.*sig_Y));

			% in case it is already computed
		eval(['tmp_mag_res00 =' mag_res00_string ';']);
		
		if strcmp(opt_anom_Var,'Var')
			tmp_Res = abs(tmp_mag_res00./Var_X);
		else
			tmp_Res = abs(tmp_mag_res00./sig_X);
		end
		
		eval([Res_string '= tmp_Res;']);

	end

end

clear tmp_* XX YY ZZ sig_X sig_Y sig_Z Var_X Var_Y Var_Z
clear a_string X0X0_string sig_X0_string ratio_string
clear b_string X00X00_string sig_X00_string 
clear Res_string mag_res0_string mag_res00_string
clear var1 var2 p1 p2
clear X0X0_*
% ======================================================================
