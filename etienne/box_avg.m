function [out,N] = box_avg(X,ibox)
%
%	Perform an area average of a given array around a 'box' to obtain a
%	time series.
%
% INPUT:    X    , variable to be area averaged (N x Nlat x Nlon)
%           ibox , indices of the box inputted as 
%                  [SW_lon,SW_lat,NE_lon,NE_lat] , see box_regions.m
%
% OUTPUT:   out , area average array
%           N   , number of grid point used in the area average
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
  tmp = reshape(tmp,[Ntime n]);
  tmp = tmp';

  % average across the area column (use nanmean to ignore NaN)
  tmp = nanmean(tmp);
  
% ----------------------------------------------------------------------

  % outputs
  out = tmp;
  N = n

end
