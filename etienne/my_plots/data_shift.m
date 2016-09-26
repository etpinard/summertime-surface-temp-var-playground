function [z,x] = data_shift(lon,data)
%
% A function that shifts data on a [0:360] longitude grid to
% a [-180:180] grid for better plotting esp. over Europe.
%
%	INPUT:		lon			, longitude vector
%						data		, associated data	(of size nlat X nlon)
%
%	OUTPUT		z				, shifted data array (of size nlat x nlon)
%						x				, new longitude vector
%
% 03/03 notice the new varout ordering
% Weird ... but cleaner for overlaying
% ============================================================

	nlon = length(lon);			% lengths and half lengths
	nlon2 = nlon/2;

	% shift data to the west by 180
	east = data(:,1:nlon2);					% longitudes [0:180]
	west = data(:,nlon2+1:nlon);		% longitudes [180:360]

	if (lon(1) >= 0)			 
		x = lon-180;			% OUTPUT: shifted longitude	(if needed)
	end
	
	z = [west east];				% shifted array [-180:180]
	
end
