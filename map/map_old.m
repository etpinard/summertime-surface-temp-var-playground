function hh=map(lon1,lon2,lat1,lat2,mapcol,dum);

% coast_180_180 and coast_0_360 are declared global in mapsetup.m

global coast_180_180 coast_0_360
mapcoldef=.6*[1 1 1];

if (nargin == 1); mapcol=lon1;end
if (nargin <= 1); lon1=0;lon2=360;lat1=-90;lat2=90;end
if (nargin == 0); mapcol=mapcoldef;end

% Error trapping
if (lon2 <= lon1); disp('Error in map.m: lon2 must be greater than lon1');return;end
if ((lon2-lon1)>360); disp('Error in map.m: lon2-lon1 must be <= 360');return;end

f1 = floor((lon1)/360);f2 = floor((lon2-.001)/360);
if f1 ==f2, 
  cfile=coast_0_360;
elseif f2 == (f1+1);
 cfile=coast_180_180;
else
 disp('error: lon2 and lon1 are to far apart')
end
%if (lon1 < 0) & (lon1 >= -180) & (lon2 <= 180);cfile=coast_180_180;
%else;
%  cfile=coast_0_360;
%end;

% compatibility with old map program
if nargin==6;mapcol=dum;end
if ( (nargin==5) & length(mapcol)>3 );mapcol=mapcoldef;end

if nargin ==4; mapcol = mapcoldef;end

x1 = cfile(:,2)+f2*360;x2 = cfile(:,1);

f = find( ( (x1 <= lon2) & (x1 >= lon1) & (x2 <= lat2) & (x2 >= lat1) ) | isnan(x1) );

ctrim=trim_coast(cfile(f,:));

hh=plot(ctrim(:,2)+f2*360,ctrim(:,1),'-');
set(hh,'col',mapcol);
