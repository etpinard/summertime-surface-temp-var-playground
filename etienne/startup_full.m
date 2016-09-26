%%% General startup file for all MATALB script folders.
	%
	% 1)  Saves the current working directory as a string
	% 2)  Defines some universal constants
	%	3)  Load variables in $vars_full (startup_vars.m) from $datapath 
	%     and check time correspondence
	% 4)  Maps the surface latent heat flux to the evaporative flux
	% 5)  Defines summer and trim the variables to summer only.
	% 6)  Saves the "global" variables in global.mat
	% 7)  Removes non-land data
	% 8)  Removes high-latitude grid boxes
	% 9)  Removes saturated grid boxes (see startup_thres.m)
	% 10) Calls anomaly_full.m 
% ======================================================================

% ./script_folder/startup.m should include: $$$$$$$$$$$$$$$$$$$$$$$$$$$$
% 
%	-) addpath(parent_dir), make_paths.m, startup_vars.m, startup_thres.m
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Save the working directory as a string
working_dir = pwd;

disp('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'); 
disp(' ')
disp(model_name); 
disp(' ')
disp(working_dir); 
disp(' ')
% ======================================================================

%% Some universal constants --- Now include m_crit
L = 2.45e6;			% Specific latent heat of vaporiation for water  [J/kg]
								% at 20 C (temp of water)
rho = 1e3;								% Desity of water		[kg/m^3]
secinday = 24*60*60;			% how many seconds in a day

m_crit = 20;		% [mm] ,  global approx. to the critical top layer
% moisture value of the boundary betweeen the transitional and wet
% evaporation regimes.
% ======================================================================

%% Load variables

	% path to data files
model_datapath = [datapath,model_name,'/'];

t=repmat(NaN,1,Nvar);			% to check time correspondance

for i=1:Nvar		% looping through the variables
	
		% path to NetCDF file
	path = [model_datapath,char(vars_full(i)),'.cdf'];
	
	if exist('path');			% if variable path exists

		%nc_dump(tmp);					% dumping information
		time = nc_varget(path,'time');		% time vector
		t(i) = time(1);										% 1st time entry 
		
			% copying the varible of interest
		tmp = nc_varget(path,char(vars_full(i)));	
		eval([char(vars(i)) '= tmp;']);

	else; continue; end		% if not, continue

end

% The model's longitude and latitude vectors (same for all variables)
lat = nc_varget(path,'lat'); 
Nlat = length(lat); 
lon = nc_varget(path,'lon'); 
Nlon = length(lon);

% To check if the files line up in time. 
check=diff(t);	 % To check if the files line up in time. 
flag = 0;					% initializing the flag
for i=1:Nvar-1;
	if check(i)~=0; disp('FILES DO NOT line up'); flag=1; end
end
if flag; break; end			% stop the procedure here.
clear model_datapath check flag t time path tmp % not needed anymore
% ======================================================================

%% Mapping the surface latent heat flux (Wm^-2) to the
 % evapotranspiration rate with units of kg m^-2 s^-1.

	%% (GFDL 2.1 only!!!) Recontructing the Evaporation rate
	 % Do this by taking the residual of the surface energy balance,
	 % assuming that it is in equilibrium on monthly time scales.
	
	if strcmp('model_name','gfdl21') && exist('E')
	
		E = (Fsd - Fsu + Fld - Flu - H);			% latent heat flux	[W/m2]
		vars = [vars,'E'];										% adding to the var cell array
		Nvar = Nvar+1;								
		disp('In the GFDL 2.1, E is the residual of F-H');
	
	end

if exist('E')
	E = E/L;
end
% ======================================================================

%% Define summer and set variables in $vars to summer only
 % (for ref. summer: NH = JJA; SH = DJF)

% Time series dimensions
Nmonth = 3;									% # of summer months (always the same)
Nyear = size(T,1)/12-1;			% 12 months for all ( -1 for both hem's)
Ntime = Nmonth*Nyear;				% # of time entries in summer-only arrays

for i=1:Nvar		% looping through the variables

	eval(['tmp = ' char(vars(i)) ';']);
	tmp = summer_only(tmp,6,8,Nyear);			% 6 to 8 --> JJA
	eval([char(vars(i)) '= tmp;']);				% reevaluating back the original	

end; clear tmp
% ======================================================================

%% Removing data over non-land grid boxes and extreme latitude 
 % in all the arrays using trim.m 
	
	% Allocate m_trim (it is model dependent)
if strcmp(trim_opt,'top'); 
	eval(['m_trim = m;']); 
end
if strcmp(trim_opt,'full');
	eval(['m_trim = m_f;']); 
end
 
 %% for more info on m_range see ../distribution2/dist.m

%% trimming every full variable using trim.m
%% (06/20), take `lat_range' from `make_paths.m'
for i=1:Nvar 

	if i==1		% to save some computing time
		eval(['[X,Iland,Nland] = land_only(' char(vars(i)) ...  
													',m_trim,m_range,lat,lat_range);']);
	else		
		eval(['X = land_only(' char(vars(i)) ...  
												',m_trim,m_range,lat,lat_range);']);
	end

	eval([char(vars(i)) ' = X;']);

end;	
clear X m_trim 
% ======================================================================

%% Saving "global" variables in global.mat
	
	% saving array dimensions
file = [parent_dir,'global.mat'];
save(file,'Ntime','Nyear','Nmonth','Nlat','Nlon','Nland','Iland', ...
					'model_name','datapath','secinday','L','m_crit');
clear file

	%% Note this is NOT equivalent to MATLAB's global variable
	%% terminology, global.mat is meant to facilitate function calls
	%% espically when Nyear and Nmonth are involved.

% ======================================================================

%% Making a list of the extracted variables.

disp('Variables extracted from NetCDF files:'); vars
disp('were trimmed to summer only,');
disp('non-land grid points were removed,');
disp('grid points of latitudes > 77 and < -55 were removed,');
disp('lakes and saturated grid boxes were removed.');
disp('==============================================================='); 
disp(' ');
% ======================================================================

% Computing climalology and parameters using anomaly_full.m

anomaly_full
% ======================================================================
