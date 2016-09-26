function ilocs = locs_add(old_locs,coord,lon,lat)
% 
% A function that updates the location lon-lat array by first 
%	converting a coordinate pair in indices.
%	
% 
% INPUT:	  old_ilocs , index location array (lon X lat) N X 2.
%											 if empty [], make an array.
%						coord		 , coordinate pair in either [-180:180] or [0:360]
%				          		 [-90:90].
%						lon			 , the model longitude vector
%						lat			 , " " latitude vector
%
% OUTPUT:		ilocs , updated index location array
%						
% =====================================================================

		% load Nyear and others via global.mat
	load('global.mat','Nlat','Nlon');
		
		% assigning lon and lat separatly
	x = coord(1);
	y = coord(2);

		% if coord_lon is [-180:180]
	if x<0;

		x = x + 360;
		
		%% Thus far, the gfld2.1 , ccsm3 and hadgem1 have longitude
		%% [0:360] vector.
		%% If you come around a model that has lon=[-180:180] then use
		%% $model_name in an extra if statement.

	end

		% find closest grid point in longitude 
	distx = abs(x-lon);
	xx = find(distx==min(distx));

		% find closest grid point in latitude
	disty = abs(y-lat);
	yy = find(disty==min(disty));

		% output the update locs vector
	if isempty(old_locs);

		ilocs = [xx,yy];

	else

		ilocs = [old_locs;xx,yy];

	end
		
end
