function out = cos_weight(X,lat)
%
% A function that weights X(time,lat,lon) by the cosine of its
% latitude.
%
% INPUT:				X			, array to be weighted
%								lat		, latitude vector
%
% OUTPUT:				out		, weighted array
% ===================================================================

	% for 2D array use repmat(cos(lat*pi/180),1,Nlon)

	Ntime = size(X,1);
	Nlat = length(lat);
	Nlon = size(X,3);

	Y = repmat(NaN,Ntime,Nlat,Nlon);

	for i=1:Nlat
		
		tmp = squeeze(X(:,i,:));
		Y(:,i,:) = cos(lat(i)*pi/180)*tmp;
	
	end

	out = Y;

		%% histogram weighted by the cosine of latitude 
		%% not that revealing ... two peaks (Tiber wins) at least
		%% for the CCSM 3.0

end
