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

  case {14,12};

    map = [103, 0, 31; 178, 24, 43; 214, 96, 77; ... 
           244, 165, 130; 253, 219, 199; 247, 247, 247; ...
           209, 229, 240; 146, 197, 222; 67, 147, 195; ...
           33, 102, 172; 5, 48, 97];

   case 10;

    map = [103, 0, 31; 178, 24, 43; 214, 96, 77; ...
           244, 165, 130; 253, 219, 199; 209, 229, 240; ...
           146, 197, 222; 67, 147, 195; 33, 102, 172; ...
           5, 48, 97];

   case 8;

%    map = [178, 24, 43; 214, 96, 77; 244, 165, 130; ... 
%           253, 219, 199; 209, 229, 240; 146, 197, 222; ...
%           67, 147, 195; 33, 102, 172];

    map = [178, 24, 43; 239, 138, 98; 253, 219, 199; ...
           191.25 191.25 191.25; 221.85 221.85 221.85; ... 
           209, 229, 240; 103, 169, 207; 33, 102, 172];

   case 2;

     map = [228, 26, 28; 55, 126, 184];

  end

  map = flipud(map);
  map = map./255;

  tmp = colormap_helper(map, N);

% ----------------------------------------------------------------------
	
	cmap = tmp;						% outputing to cvec level #
	
end