function X = getnetcdf(var_full,opt_dump)
%
%	A function that extracts the main field out of a
%	netCDF file to a MATLAB array.
%
%	This function is meant to simplify the extraction of additional 
% field (e.g. prc.cdf). Use startup_full.m, via startup.m for
% mass extraction of the Toy Model variables.
%	
% INPUT:				var_full		, string of $var_full.cdf
%																e.g. var_full = 'tas' for the 2m
%																temperature.
%								opt_dump		,	put 1 for an nc_dump.
%
% OUTPUT:				X						, the output MATLAB array.
% ===================================================================
	
		% load path to data files from globat.mat
	load('global.mat','datapath','model_name');
	
	t = repmat(NaN,1,2);			% to check time correspondance
	
		% path to NetCDF file
	path = [datapath,model_name,'/',var_full,'.cdf'];
		
	if exist(path);			% if variable path exists
	
	 	time = nc_varget(path,'time');		% time vector
	 	t(1) = time(1);										% take the 1st time entry 
	 	
	 		% extracting the varible of interest
		disp(['$$$ Extracting ... ', var_full '.cdf']);
	 	tmp = nc_varget(path,var_full);	

			% dumping information if requested
		if exist('opt_dump') && opt_dump
			nc_dump(path,var_full);				
		end
	
	else
		
		disp('Path not found');
		return

	end		
	
		% outputing the MATLAB array
	X = tmp;

	return
		
%	% Testing if longitude and latitude vectors line up 
%	% (think about a way to automate this) ... should be fine
%	lat = nc_varget(path,'lat');
%	Nlat = length(lat); Nlat2 = Nlat/2; 
%	lon = nc_varget(path,'lon'); 
%	Nlon = length(lon); Nlon2 = Nlon/2;
	
	
	%% To check if the files line up in time. 
			
	path_check = [datapath,model_name,'/','tas.cdf'];	
			% taken tas for instance ...
	time = nc_varget(path_check,'time');		% initial of a known variable
	t(2) = time(1);
	
	check=diff(t);		% To check if the files line up in time. 
	flag = 0;					% initializing the flag
	
	if check~=0; 

		disp('FILES DO NOT line up'); 
		flag=1;

	end

end
