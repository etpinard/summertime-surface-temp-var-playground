function cmap = color_myhot2(cvec)
%
% A 2nd custom version of the `hot' color_map downloaded from the
% MATLAB file exchange webspite, in ~/proj/file_exchange/ .
%
% INPUT:		cvec		, contour level vector
% OUTPUT:		cmap		, normalized RGB color map
% ======================================================================

	%	# of colors
  N = length(cvec)-1;
  
  switch N

  case {6,7,8};
    map = [255 255 178; ...
           254 217 118; ...
           254 178 76; ...
           253 141 60; ...
           240 59 32; ...
           189 0 38];

  case 5;
    map = [255 255 178; ...
           254 204 92; ...
           253 141 60; ...
           240 59 32; ...
           189 0 38];
  
  end


  map = map./255;

  tmp = colormap_helper(map, N);

% ----------------------------------------------------------------------
	
	cmap = tmp;						% outputing to cvec level #
	
end
