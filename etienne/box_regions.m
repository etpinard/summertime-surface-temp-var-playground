% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% box_regions.m 
%
%	Define location 'boxes' for time series analysis.
%
% The 'boxes' are defined by their SW and NE corners:
%
%  - box_$num : [lon_SW,lat_SW,lon_NE,lat_NE] in degrees.
%  - ibox_$num : corresponding indices on the dataset's grid.
%  - Ibox_$num : 
%
% Calls `locs_add.m' to determine to closest grid indicies.
%
% *** I should make the 'boxes' dataset dependent as the regions of
% high bias are not the same in each gcms.
%
% ======================================================================


%% Define boxes 

% 1) Central US
sw = [-110,30]; ne = [-88,48];
box_1 = [sw,ne];
ibox_1 = [locs_add([],sw,lon,lat), ...
          locs_add([],ne,lon,lat)];
tmp = repmat(NaN,Nlat,Nlon);
tmp(ibox_1(2):ibox_1(4),ibox_1(1):ibox_1(3)) = 1;
Ibox_1 = tmp;
% ----------------------------------------------------------------------

% 2) Central Europe
sw = [18,45]; ne = [40,60];
box_2 = [sw,ne];
ibox_2 = [locs_add([],sw,lon,lat), ...
          locs_add([],ne,lon,lat)];
tmp = repmat(NaN,Nlat,Nlon);
tmp(ibox_2(2):ibox_2(4),ibox_2(1):ibox_2(3)) = 1;
Ibox_2 = tmp;
% ----------------------------------------------------------------------

% 3) Amazon 
sw = [-65,-25]; ne = [-40,2];
box_3 = [sw,ne];
ibox_3 = [locs_add([],sw,lon,lat), ...
          locs_add([],ne,lon,lat)];
tmp = repmat(NaN,Nlat,Nlon);
tmp(ibox_3(2):ibox_3(4),ibox_3(1):ibox_3(3)) = 1;
Ibox_3 = tmp;
% ----------------------------------------------------------------------

clear tmp
% plot boxes on map to check ...
%plot_box_regions([ibox_1;ibox_2],lat,lon,{'both','dry1-2'});
%plot_box_regions([ibox_1;ibox_3],lat,lon,{'both','dry-wet'});
% ======================================================================
