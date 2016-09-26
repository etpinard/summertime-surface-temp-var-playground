%%% My Matlab programme that specifies the locations (corresp. to
	% different climate regimes) around the globe to be used for 
	% time series and scatter plots of various parameters 
	%
	% Now calls locs_add.m to facilitate the addition of new locations
	%
	% The best way to determine coordinate pairs is to run ./worldmap.sh
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

opt_locs = 'classic';

%% Specifying the locations coordinates in longitude [-180,180] (or
%	 [0,360]) and latitude [-90,90] using locs_add.m
	
	%% NOTE: "locs" is reserved for the lon,lat array corresp. to the
	%% indices % in $ilocs. locs is needed for plot_locations, but nothing
	%% else (I % think). So ilocs is more important.

switch opt_locs

case 'classic'

% The "classic" used up until January 2013

	% Southeast US
ilocs = locs_add([],[-102,42],lon,lat);
	% Western Europe
%ilocs = locs_add(ilocs,[4,50],lon,lat);				
	% Central Europe
ilocs = locs_add(ilocs,[29,53],lon,lat);		
	% Siberia
ilocs = locs_add(ilocs,[104,72],lon,lat);		
	% Southeast China
ilocs = locs_add(ilocs,[111,31],lon,lat);		
	% Central Australia
%ilocs = locs_add(ilocs,[134.5,-20],lon,lat);		
	% Sahara
%ilocs = locs_add(ilocs,[13,27.5],lon,lat);		
	% Central Africa (Congo)
ilocs = locs_add(ilocs,[20,-3],lon,lat);		
	% Amazon (actually just south of it)
%ilocs = locs_add(ilocs,[-58,-6],lon,lat);		
	% Thailand / Vietnam
%ilocs = locs_add(ilocs,[103,18],lon,lat);		
	% Korea / Manchuria
%ilocs = locs_add(ilocs,[124.5,44.5],lon,lat);		
% =====================================================================

case 'evapo'

% (02/06) locations based on regressions of E' on m' and F_0'

% US prairies --- good
ilocs = locs_add([],[-102,42],lon,lat);
% Central Europe -- good
ilocs = locs_add(ilocs,[29,53],lon,lat);		
% Central Australia -- good
ilocs = locs_add(ilocs,[134.5,-20],lon,lat);		
% Eastern Us --- not good in Hadgem1
ilocs = locs_add(ilocs,[-83,40],lon,lat);
% Thailand / Vietnam --- not good in both
ilocs = locs_add(ilocs,[103,18],lon,lat);		
% North Siberia --- not good in both
ilocs = locs_add(ilocs,[104,72],lon,lat);		
	% I should add France/ Germany too however it not exactly the same
	% location for both models ...
% =====================================================================

case 'damping'

% (03/21) locations based on parameterization of H' (see bld_T_H00.m)

% Alberta prairies --- low bias
ilocs = locs_add([],[-110,50],lon,lat);
% Central Europe -- low bias	(same as 02/06)
ilocs = locs_add(ilocs,[29,53],lon,lat);			
% Central Australia -- low bias (same as 02/06)
ilocs = locs_add(ilocs,[134.5,-20],lon,lat);		
% Southwest US --- high bias
ilocs = locs_add(ilocs,[-120,40],lon,lat);
% Middle East --- high bias
ilocs = locs_add(ilocs,[40,34],lon,lat);		
% Northeast Russia  --- high bias (esp. in hadgem1)
ilocs = locs_add(ilocs,[40,64],lon,lat);		
% =====================================================================

end

% How many locations, a nice constant to have around
Nlocs = size(ilocs,1);

% Plottng the coordinates on a Miller map
locs = [lon(ilocs(:,1)),lat(ilocs(:,2))];
plot_locations(locs)
clear locs													 % As said, I don't know I need this
% ======================================================================
