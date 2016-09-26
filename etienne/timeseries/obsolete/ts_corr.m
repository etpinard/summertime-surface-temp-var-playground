%%% My Matlab programme that computes point-correlation time series 
	% for specific locations	(climate regimes) around the globe.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and locations.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% Computing climatology and anomalies using anomaly.m

Nyear = 30;															% how many years in the sample
Nmonth = 3;																% how many months in summer
Ntime = 90;																% total # of sample points

[Tbar,TT,sig_T] = anomaly(T,Nyear);		
[mbar,mm,sig_m] = anomaly(m,Nyear);			% no need for sigmas

% more variables later ...
% ======================================================================

%% Restricting XX and sig_X to only the specific locations in $locs
	% ... not Xbar for now ...

for i=1:2					% only T and m for now
	
		% allocating X and sig_X
	eval(['X = ' char(vars(i)) char(vars(i)) ';']);
	eval(['sig_X = sig_' char(vars(i)) ';']);

		% initializing the temporary arrays
	tmp1 = zeros(Ntime,Nlocs);
	tmp2 = zeros(Nmonth,Nlocs);

	for l=1:Nlocs			% looping through the coordinates 
		tmp1(:,l) = squeeze(X(:,yy(l),xx(l))); 
		tmp2(:,l) = squeeze(sig_X(:,yy(l),xx(l))); 
	end

		% overwritting XX and sig_X		(should not be an issue)
	eval([char(vars(i)) char(vars(i)) ' = tmp1;']);	
	eval(['sig_' char(vars(i)) ' = tmp2;']);	

end; clear tmp1 tmp2 l
% ======================================================================

%% Finding the possible variable and month pairs

% The possible pairs in-between variables
tmp = [1:2];										% for now just T and m
pair_v = combntns(tmp,2);		
Npair_v = length(pair_v(:,1));

% The possible pairs in-between months
tmp = [1:3];										% 3 month summer (for now)
pair_m = combntns(tmp,2);			
Npair_m = length(pair_m(:,1));
% ======================================================================

%% Computing instantaneous monthly correlations

for i=1:Npair_v				% looping through correlation pairs
	
		% allocating the two variables to correlate
	eval(['X = ' char(vars(pair_v(i,1))) char(vars(pair_v(i,1))) ';']);
	eval(['sig_X = sig_' char(vars(pair_v(i,1))) ';']);
	eval(['Y = ' char(vars(pair_v(i,2))) char(vars(pair_v(i,2))) ';']);
	eval(['sig_Y = sig_' char(vars(pair_v(i,2))) ';']);

		% the product of the anomalies at the coordinates of $locs	
	Z = X.*Y;

		% replicating sig_X and sig_Y over $Nyear years
	sig_X = repmat(sig_X,Nyear,1);
	sig_Y = repmat(sig_Y,Nyear,1);

	tmp = Z./(sig_X.*sig_Y);
		
		% evaluating to cor_$var1$var2
	eval(['corr_' char(vars(pair_v(i,1))) char(vars(pair_v(i,2))) ...
						' = tmp;']);
		
end;		clear X Y sig_X sig_Y
% ======================================================================

%% Computing the lag monthly correlations of the same variable.

for i=1:2				% looping through variables (just T and m)
	
		% allocating to a temporary variable
	eval(['X = ' char(vars(i)) char(vars(i)) ';']);
	eval(['sig_X = sig_' char(vars(i)) ';']);

		% reshape into $Nmonth rows per locations
	X = reshape(X,Nmonth,Nyear,Nlocs);	

	for j=1:Npair_m			% looping through month pairs
	
			% computing the lagged product
		Z = squeeze(X(pair_m(j,1),:,:)).* ...
					squeeze(X(pair_m(j,2),:,:));
			
			% respective monthly std's
		sig_X1 = squeeze(sig_X(pair_m(j,1),:,:));
		sig_X1 = repmat(sig_X1,Nyear,1);
		sig_X2 = squeeze(sig_X(pair_m(j,2),:,:));
		sig_X2 = repmat(sig_X2,Nyear,1);

			% Correlation coefficient 
		tmp =  Z./(sig_X1.*sig_X2);
		
		% evaluating to "cor_$var$pair_m1$par_m2
	eval(['corr_' char(vars(i)) num2str(pair_m(j,1)) ...
															num2str(pair_m(j,2)) ...
						' = tmp;']);

	end
end;		clear X Z sig_X sig_X1 sig_X2  
% ======================================================================

%% Computing the lag monthly correlations for paired variables.

for i=1:Npair_v			% looping through the possible paired variables
	
		% allocating the two variables to correlate
	eval(['X = ' char(vars(pair_v(i,1))) char(vars(pair_v(i,1))) ';']);
	eval(['sig_X = sig_' char(vars(pair_v(i,1))) ';']);
	eval(['Y = ' char(vars(pair_v(i,2))) char(vars(pair_v(i,2))) ';']);
	eval(['sig_Y = sig_' char(vars(pair_v(i,2))) ';']);
		
		% reshape into $Nmonth rows per locations
	X = reshape(X,Nmonth,Nyear,Nlocs);	
	Y = reshape(Y,Nmonth,Nyear,Nlocs);	
		
	% This will have to be automated at one point ...
		% Probably just a flip of pair_m ...

	for j=1:Npair_m			% looping through month pairs		(1st loop)

			% computing the lagged product
		Z = squeeze(X(pair_m(j,1),:,:)).* ...
					squeeze(Y(pair_m(j,2),:,:));

			% respective monthly std's
		sig_X1 = squeeze(sig_X(pair_m(j,1),:,:));
		sig_X1 = repmat(sig_X1,Nyear,1);
		sig_Y1 = squeeze(sig_Y(pair_m(j,2),:,:));
		sig_Y1 = repmat(sig_Y1,Nyear,1);
		
			% Correlation coefficient 
		tmp =  Z./(sig_X1.*sig_Y1);
		
		% evaluating to "cor_$var1$pair_m1$var2$pair_m2
	eval(['corr_' char(vars(pair_v(i,1))) num2str(pair_m(j,1)) ...
									char(vars(pair_v(i,2))) num2str(pair_m(j,2)) ...
						' = tmp;']);
	end
	
	for j=1:Npair_m			% looping through month pairs		(2nd loop)
			
			% computing the lagged product
		Z = squeeze(X(pair_m(j,2),:,:)).* ...
					squeeze(Y(pair_m(j,1),:,:));

			% respective monthly std's
		sig_X1 = squeeze(sig_X(pair_m(j,2),:,:));
		sig_X1 = repmat(sig_X1,Nyear,1);
		sig_Y1 = squeeze(sig_Y(pair_m(j,1),:,:));
		sig_Y1 = repmat(sig_Y1,Nyear,1);
		
			% Correlation coefficient 
		tmp =  Z./(sig_X1.*sig_Y1);

		% evaluating to "cor_$var1$pair_m1$var2$pair_m2
	eval(['cor_' char(vars(pair_v(i,1))) num2str(pair_m(j,2)) ...
									char(vars(pair_v(i,2))) num2str(pair_m(j,1)) ...
						' = tmp;']);
	end

end;		clear X Y sig_X sig_Y sig_X1 sig_Y1 Z tmp
% ======================================================================

%% Making a list of the correlations computed.
disp('We computed the following correlation functions');
whos corr_*
disp('====================================');
%======================================================================
