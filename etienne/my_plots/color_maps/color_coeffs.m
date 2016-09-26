function cmap = color_corr(cvec)
%
% Custom color map for toy model coefficients
%
% INPUT:		cvec		, contour level vector
% OUTPUT:		cmap		, normalized RGB color map
% ======================================================================

	%	# of colors
  N = length(cvec)-1;
  
  if cvec(1)>=0

    switch N

      case 5;
      map = [103, 0, 31; 178, 24, 43; 214, 96, 77; ...
             244, 165, 130; 253, 219, 199];
      map = flipud(map);

      case 6;
      map = [103, 0, 31; 178, 24, 43; 214, 96, 77; ...
             244, 165, 130; 253, 219, 199];
      map = flipud(map);
      map = [map; 45, 0, 75];

    end

  else

    switch N

      case 10;
      map = [103, 0, 31; 178, 24, 43; 214, 96, 77; ...
             244, 165, 130; 253, 219, 199; 209, 229, 240; ...
             146, 197, 222; 67, 147, 195; 33, 102, 172; ...
             5, 48, 97];
      map = flipud(map);

      case 6;
      map = [103, 0, 31; 178, 24, 43; 214, 96, 77; ...
             244, 165, 130; 253, 219, 199];
      map = flipud(map);
      map = [209, 229, 240; map];
    
      case 7;
      map = [103, 0, 31; 178, 24, 43; 214, 96, 77; ...
             244, 165, 130; 253, 219, 199];
      map = flipud(map);
      map = [209, 229, 240; map; 45, 0, 75];
    
    end

  end

  map = map./255;
  tmp = colormap_helper(map, N);

% ----------------------------------------------------------------------
	
	cmap = tmp;						% outputing to cvec level #
	
end
