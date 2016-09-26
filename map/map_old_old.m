function hh=map(lon1,lon2,lat1,lat2,cfile,mapcol);

if nargin < 6; mapcol = 'y';end

x1 = cfile(:,1);x2 = cfile(:,2);

f = find( (x1 < lon2) & (x1 > lon1) & (x2 < lat2) & (x2 > lat1) );

hh=plot(x1(f),x2(f),'.')
set(hh,'col',mapcol);
