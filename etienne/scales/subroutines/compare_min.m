%%% Procedure that compute ratio of a small variable 
	% to the pointwise minimum of a set of variables.
	%
	% It is meant to determine in one of the terms is negligible
	%
	%	This procedure can also be used to compare "whole" terms.
	% e.g. to compare sig_R (=var_small) to sig_(P-E) (=vars_big)
	%
	%	And it can also accomodate Nlat x Nlon arrays e.g. to scale
	%	the time derivatives (in that case all variables in var_small and
	% vars_big NEED to be of the same size.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Requires: var_small , vars_big 
%%	and note that the variables in vars_pairs are the actual variable
%%	to be utilized for the ratio (unlike e.g. in correlations/)
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Find length of vars_big (now here!)
Nvar_big = length(vars_big);

%% Allocate var_small to X
eval(['X =' char(var_small) ';']);
% ======================================================================

%% Find the pointwise minimum 

if Nvar_big>1
	
		% initialize the "den_all" array
	if ndims(X)==2 
		den_all = zeros(Nvar_big,1,Nlat*Nlon);
	else
		den_all = zeros(Nvar_big,Nmonth,Nlat*Nlon);
	end
	
		% loop through all variable in $vars_big
	for i=1:Nvar_big
	
		eval(['Y = ' char(vars_big(i)) ';']);
	
			% reshape Y into Nmonth X Nlat*Nlon and fill in "den_all"
		if ndims(X)==2
			Y = reshape(Y,1,Nlat*Nlon);		
			den_all(i,:,:) = Y;
		else
			Y = reshape(Y,Nmonth,Nlat*Nlon);		% to keep in 3D
			den_all(i,:,:) = Y;
		end
	
	end
	
		% compute the minimum column-wise, finding the denominator den
	den = sqz(nanmin(den_all));

	if ndims(X)==2
		den = reshape(den,Nlat,Nlon);			% back to  Nlat X Nlon
	else
		den = reshape(den,Nmonth,Nlat,Nlon);	% back to Nmonth X Nlat X Nlon
	end
	
		%% Should I make den not-temp. with a derived (from vars_big) name?

else

	eval(['Y = ' char(vars_big) ';']);

end


% ======================================================================

%% Compute the scaling ratio

	% set the output variable name
scale_string = ['scale_min_' char(var_small) '_'];
for i=1:Nvar_big 
	scale_string = [scale_string , char(vars_big(i))];
end

	% compute 
if ~exist(scale_string)

	disp(['Computing ... ' scale_string]);

	tmp_scale = X./den;

	eval([scale_string '= tmp_scale;']);

end

clear tmp_* X Y scale_string den_all den
