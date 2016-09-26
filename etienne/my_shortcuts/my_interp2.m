function out = my_interp2(X,lat_old,lon_old,lat_new,lon_new,Iland_new)
%
%	Interpolate a 2D or 3D array in 2 dimensions from one
%	set of [lon,lat] to another.
%
% INPUT:			X		 	  , 2D or 3D array to interpolate
%             lat_old , latitude vector of X
%             lon_old , longitude vector of X
%             lat_new , latitude vector of to interpolate to
%             lon_new , longitude vector of to interpolate to
%             Iland_new, (optional) land indices on new grid
% 
% OUTPUT:		  out   , interpolated array
%							
% ====================================================================


  % build mesh grid for old lat,lon
  [mesh_lat_old,mesh_lon_old] = meshgrid(lon_old,lat_old);
  
  % build mesh grid for new lat,lon
  [mesh_lat_new,mesh_lon_new] = meshgrid(lon_new,lat_new);

  if ndims(X)==2

    % if 2D, call MATLAB's 'interp2' directly

    tmp = ...
      interp2(mesh_lat_old,mesh_lon_old,X, ...
              mesh_lat_new,mesh_lon_new);

  elseif ndims(X)==3

    % if 3D, call 'interp2' one sheet at a time

    Nsheet = size(X,1);

    Nlat_new = length(lat_new);
    Nlon_new = length(lon_new);

    tmp = zeros(Nsheet,Nlat_new,Nlon_new);

    for i=1:Nsheet
    
      X1 = sqz(X(i,:,:));

      tmp(i,:,:) =  ...
        interp2(mesh_lat_old,mesh_lon_old,X1, ...
                mesh_lat_new,mesh_lon_new);
      
    end

    % ** make Iland_new 3D
    Iland_new = x2d(Iland_new);

  else

    disp('*** input array must be 2D or 3D')
    return

  end

  if nargin==6

    % remove NaNs for 'tmp'
    I_nan = isnan(tmp);
    tmp(I_nan) = 0;

    % use 'Iland_new' to trim to land only
    tmp = tmp.*Iland_new;
 
  end

% ----------------------------------------------------------------------


  % output the result
  out = tmp;

end
