function [out,Ngrid] = box_avg(X,ibox)
%
%	Concatenates every grid point of a given array inside a 'box' to
%	obtain a time series of ($Ngridpt x $Ntime) entries.
%
% INPUT:    X    , variable to be area averaged (N x Nlat x Nlon)
%           ibox , indices of the box inputted as 
%                  [SW_lon,SW_lat,NE_lon,NE_lat] , see box_regions.m
%
% OUTPUT:   out , area average array
%           Ngrid   , number of grid point used in the area average
%
% *** Maybe I should place this in my_shortcuts/
%
% ======================================================================

  % retrieve the number of time entries
  Ntime = size(X,1);
  
  % retrieve indices from 'ibox'
  lon1 = ibox(1);
  lat1 = ibox(2);
  lon2 = ibox(3);
  lat2 = ibox(4);

  % compute number of grid points to be averaged
  n = (lon2-lon1+1)*(lat2-lat1+1);

  % select grid points inside the box 
  tmp = X(:,lat1:lat2,:);
  tmp = tmp(:,:,lon1:lon2); 

  % reshape array 
%  tmp = reshape(tmp,[Ntime n,1]);
%  tmp = tmp';
  
  tmp = make1d(tmp);

% ----------------------------------------------------------------------

  % outputs
  out = tmp;
  Ngrid = n;

end
