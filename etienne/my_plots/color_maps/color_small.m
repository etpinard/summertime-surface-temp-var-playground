function cmap = color_small(cvec)
%
% Custom color map for correlations
%
% INPUT:		cvec		, contour level vector
% OUTPUT:		cmap		, normalized RGB color map
% ======================================================================

	%	# of colors
  N = length(cvec)-1;
 
  switch N

   case {6,7};

     map = [142, 1, 82; 197, 27, 125; 222, 119, 174; ...
            241, 182, 218;  ...
            230, 245, 208;  ... 
            127, 188, 65; 77, 146, 33; 39, 100, 25];

   end

  map = flipud(map);

  map = map./255;

  tmp = colormap_helper(map, N);

% ----------------------------------------------------------------------
	
	cmap = tmp;						% outputing to cvec level #
	
end
