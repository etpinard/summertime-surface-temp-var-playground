function cmap = color_relerror(cvec)
%
% Color map for relative errors plots.
%
% (07/14) A misnomer. Should I've been named 'color_error_ratio' 
%
% Optimal for [4 neg, 0, 4 pos] contours
% or more specifically for cvec= [0.0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4]
%
% Makes use of `colormap_helper.m' from MATLAB's file exchange library
% (locally in ~/proj/file_exchange/)
%
% INPUT:		cvec			, contour level vector (of const. step)
% OUTPUT:		cmap			, RGB color map
% ====================================================================

%    186, 186, 186; ...      % dark grey
%    209, 229, 240; ...      % blue
%    8, 81, 156; ...

	%	# of colors
	N = length(cvec)-1;
	
%  % option 1.
%  map = [ ...
%    45, 0, 75;...           % outlier dark purple
%    33, 102, 172; ...       % blue
%    67, 147, 195; ...       % blue
%    146, 197, 222; ...      % blue
%    224, 224, 224; ...      % light grey
%    224, 224, 224; ...      % light grey
%    244, 165, 130; ...      % red
%    214, 96, 77; ...        % red
%    178, 24, 43; ...        % red
%    84, 48, 5; ...          % outlier brown
%    ];

  % option 2.
  map = [ ...
    77, 0, 75; ...
    37, 52, 148; ...
    29, 145, 192; ...
    127, 205, 187; ...
    224, 224, 224; ...      % light grey
    224, 224, 224; ...      % light grey
    254, 217, 118; ...
    253, 141, 60; ...
    189, 0, 38; ...
    84, 48, 5; ...          % outlier brown
    ];

  % call `colormap_helper.m'
  map = map./255;
  map = colormap_helper(map, N);

% ----------------------------------------------------------------------

	cmap = map;						% outputing to cvec level #

end
