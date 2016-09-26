%%% Procedure that compute all possible ratios of pairs of variables
	% in a given set of variables. It is meant to compare scales of terms
	% e.g. Xbar, Var_X, sig_X.
	% 
	% Variable looping is based on combinatorics.
	%
	% The denominator is set to be the biggest (globally) of the two
	% terms to better determine if approximations are valid.
	% The output name will reflect which variable is indeed the
	% denominator.
	%
	% The runoff variable is causing some issues. Its spatial mean is
	% much larger than its characterics anomaly magnitude.
	% So, the runoff (R and R_b) quantities will always be at the
	% numerator.
	%
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Requires: vars_pairs , (NEW!) opt_lock
%%	and note that the variables in vars_pairs are the actual variable
%%	to be utilized for the ratio (unlike e.g. in correlations/)
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

% Now computed here!
Nvar_pairs = length(vars_pairs);
% ======================================================================

% if opt_lock does not exist
if ~exist('opt_lock')
	opt_lock=0; end
% ======================================================================

%% Finding the possible variable pairs

tmp = [1:Nvar_pairs];										
combs_v = combntns(tmp,2);	% "combs" for combinations
Ncomb_v = size(combs_v,1);	% "_v" for variable 
clear tmp										% not to confuse with "_m" for month
% ======================================================================

%% Initializing an array to keep track of which variable is the den.
dens = zeros(Ncomb_v,1);
% ======================================================================

for i=1:Ncomb_v

		% allocating the combs_v indices
	p1 = combs_v(i,1);
	p2 = combs_v(i,2);

		% allocating var_pairs of indices p1 and p2
	var1 = vars_pairs(p1);
	var2 = vars_pairs(p2);
	
		% allocating the two variables for the ratio
	eval(['X = ' char(var1) ';']);
	eval(['Y = ' char(var2) ';']);

		% if opt_lock, den is the latter variable in vars_pairs
	if opt_lock 

		scale_string = ['scale_' char(var1) '_' char(var2)];
		
		if ~exist(scale_string) 

				% very simply, the ratio
			disp(['Computing ... ' scale_string]);
			tmp_scale = X./Y;	
			eval([scale_string '= tmp_scale;']);
			
		end
		
		dens(i) = 2;		% var2 is the den.
	
		% if one of the 2 variable is runoff based
		% *** Update this to opt_lock terminology
	elseif strcmp(var1,'Var_R') || strcmp(var1,'sig_R') %|| (more to come ??)

		scale_string = ['scale_' char(var1) '_' char(var2)];
	
		if ~exist(scale_string) 

				% very simply, the ratio
			disp(['Computing ... ' scale_string]);
			tmp_scale = X./Y;	
			eval([scale_string '= tmp_scale;']);
			
		end
		
		dens(i) = 2;		% var2 (not runoff) is the den.

	elseif strcmp(var2,'Var_R') || strcmp(var2,'sig_R')
			
		scale_string = ['scale_' char(var2) '_' char(var1)];
	
		if ~exist(scale_string) 

				% very simply, the ratio
			disp(['Computing ... ' scale_string]);
			tmp_scale = Y./X;	
			eval([scale_string '= tmp_scale;']);
			
		end
		
		dens(i) = 1;		% var2 (runoff) is the den.

	else

			% if not, find which of X and Y is bigger by ...
		meanX = mean1d(X);
		meanY = mean1d(Y);

		if meanX<meanY		% Y>X --> Y is the denominator

			scale_string = ['scale_' char(var1) '_' char(var2)];
		
			if ~exist(scale_string) 

					% very simply, the ratio
				disp(['Computing ... ' scale_string]);
				tmp_scale = X./Y;	
				eval([scale_string '= tmp_scale;']);
				
			end
			
			dens(i) = 2;		% var2 is the den.

		else							% Y<X --> X is the denominator

			scale_string = ['scale_' char(var2) '_' char(var1)];

			if ~exist(scale_string) 

					% very simply, the ratio
				disp(['Computing ... ' scale_string]);
				tmp_scale = Y./X;	
				eval([scale_string '= tmp_scale;']);
				
			end
			
			dens(i) = 1;		% var1 is the den.

		end
	
	end

end

clear tmp_* X Y meanX meanY scale_string
clear var1 var2 p1 p2
