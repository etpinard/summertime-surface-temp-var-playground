function cmap = color_scale(cvec)
%
% Custom color map for correlations
%
% INPUT:		cvec		, contour level vector
% OUTPUT:		cmap		, normalized RGB color map
% ======================================================================

	%	# of colors
  N = length(cvec)-1;
 
  % if cvec starts at 0.0: green to white to brown 
  if cvec(1)>=0

    switch N

     case 8;
%       map = [140, 81, 10; 191, 129, 45; 223, 129, 125; ...
%              246, 232, 195; 199, 234, 229; 128, 205, 193; ...
%              53, 151, 143; 1, 102, 94];
       map = [140, 81, 10; 191, 129, 45; 223, 194, 125; ...
              246, 232, 195; 199, 234, 229; 128, 205, 193; ...
              53, 151, 143; 1, 102, 94];

      case 10;
        map = [84, 48, 5; 140, 81, 10; 191, 129, 45; ...
               223, 194, 125; 246, 232, 195; 199, 234, 229; ...
               128, 205, 193; 53, 151, 143; 1, 102, 94; 0, 60, 48];

     end

    map = flipud(map);

    % if cvec starts < 0.0: 
    else 

      switch N

      case 16
        map_pos = [140, 81, 10; 191, 129, 45; 223, 194, 125; ...
                   246, 232, 195; 199, 234, 229; 128, 205, 193; ...
                   53, 151, 143; 1, 102, 94];
        map_neg = [118, 42, 131; 153, 112, 171; 194, 165, 207;
                   231, 212, 232; 217, 240, 211; 166, 219, 160; ...
                   90, 174, 97; 27, 120, 55];
        map = [map_neg;flipud(map_pos)];

      case 2
        map = [216, 179, 101; 90, 180, 172];

      end

    end

  map = map./255;

  tmp = colormap_helper(map, N);

% ----------------------------------------------------------------------
	
	cmap = tmp;						% outputing to cvec level #
	
end
