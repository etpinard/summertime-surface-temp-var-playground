function [Y,Nlat2,Nlon2] = resdown(X,fact)
%
%	Trim resolution down of a 3D (time,lat,lon) array 
% or a 2D (lat,lon) array
% down to an integer multiple of its current resolution.
%
% INPUT:		X      , (time,lat,lon) array to be trimmed
%           fact   , integer factor by which resolution will be trimmed
%                    default: fact=2.
% 
% OUTPUT:		Y      , (time,lat/fact/lon/fact)
%           Nlat2  , # of latitude values in new resolution
%     Nlon2  , # of longitude values in new resolution
%
% *** Maybe I should have lat and lon as input too 
%     and output lat2 and lon2 ...
%
% ====================================================================

 
  % get X's Nlat & Nlon
  if ndims(X)==2
    Nlat = size(X,1);
    Nlon = size(X,2);
  else
    Nlat = size(X,2);
    Nlon = size(X,3);
  end

  % By default fact=2
  if nargin==1
    fact = 2; end

  % Indices steps, avoid the even-or-odd problem
  Ilat = [1:fact:Nlat];
  Ilon = [1:fact:Nlon];
  
  % Trim resolution using indices steps
  if ndims(X)==2
    Y = X(Ilat,Ilon);
  else
    Y = X(:,Ilat,Ilon);
  end

  % length of indices steps
  Nlat2 = length(Ilat);
  Nlon2 = length(Ilon);
  
end
