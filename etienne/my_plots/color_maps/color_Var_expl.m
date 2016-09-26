function cmap = color_corr(cvec)
%
% Custom color map for correlations
%
% INPUT:		cvec		, contour level vector
% OUTPUT:		cmap		, normalized RGB color map
% ======================================================================

	%	# of colors
  N = length(cvec)-1;
  
  switch N

   case 10;

   case 7;

    map = [ ...
      255, 255, 255; ...
      208, 209, 230; ...
      166, 189, 219; ...
      103, 169, 207; ...
      28, 144, 153; ...
      1, 108, 89];
   
   case 8;

    map = [ ...
      255, 255, 255; ...
      208, 209, 230; ...
      166, 189, 219; ...
      103, 169, 207; ...
      28, 144, 153; ...
      1, 108, 89; ...
      1, 70, 54];

  end

  map = map./255;

  tmp = colormap_helper(map, N);

% ----------------------------------------------------------------------
	
	cmap = tmp;						% outputing to cvec level #
	
end
