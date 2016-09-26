function cmap = color_Var(cvec)
%
% Custom color map for Variance
%
% INPUT:		cvec		, contour level vector
% OUTPUT:		cmap		, normalized RGB color map
% ======================================================================

	%	# of colors
  N = length(cvec)-1;
  
  switch N

  case {6,7,8}; 
    map = [254, 235, 226; 252, 197, 192; 250, 159, 181;  ...
           247, 104, 161; 221, 52, 151; 174, 1, 126; 122, 1, 119];

%    map = [255, 255, 204; 199, 233, 180; 127, 205, 187;  ...
%           65, 182, 196; 29, 145, 192; 34, 94, 168; 12, 44, 132];
    
    map = [217,217,217;  253, 141, 60;   ...
           221, 52, 151; 73, 0, 106];
%    map = flipud(map);

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
