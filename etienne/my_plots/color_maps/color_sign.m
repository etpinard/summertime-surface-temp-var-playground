function cmap = color_sign(cvec)
%
% Custom color map for sign (<1 or >1)
%
% INPUT:		cvec		, contour level vector
% OUTPUT:		cmap		, normalized RGB color map
% ======================================================================

	%	# of colors
  N = length(cvec)-1;
 
    switch N

     case 2;
       map = [2,2,2 ; ...
              255,255,255];
     end

  map = map./255;

  tmp = colormap_helper(map, N);

% ----------------------------------------------------------------------
	
	cmap = tmp;						% outputing to cvec level #
	
end
