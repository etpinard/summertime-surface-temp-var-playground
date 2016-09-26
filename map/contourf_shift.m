function [cs,h]=contourf_shift(lon,lat,data,v)
% this function takes an array of data on the 0 360 grid and shifts it
% to the -180 180 grid
  lon=lon-180;nlon=length(lon);
  [nlat,nlon]=size(data);
   nlon2=nlon/2;
   if rem(nlon,2) > 0
       'cant do -- need even number of longitudes',stop
   else
   end
   left=data(:,1:nlon2);right=data(:,nlon2+1:nlon);
   data_shift =[right left];
 if (nargin == 4)
     [cs,h]=contourf(lon,lat,data_shift,v);
 else
     cs=[];h=[];
     contourf(lon,lat,data_shift);
 end
   % hold on; map('k');hold off
   hold on; map(lon(1),lon(nlon),lat(1),lat(nlat),'k');hold off
end

