function cmap = color_myhot(cvec)
%
% My version of the `hot' color_map downloaded from the MATLAB file
% exchange website, in ~/proj/file_exchange/ .
%
% INPUT:		cvec		, contour level vector
% OUTPUT:		cmap		, normalized RGB color map
% ======================================================================

	%	# of colors
  N = length(cvec)-1;
  
%  tmp = hot(Ncvec+1);			
%  tmp = flipud(tmp(2:Ncvec,:));			
	
  map = [65 182 196; ...
         254 250 217; ...
         253 204 138; ...
         252 141 51; ...
         227 74 51;
         179 0 0; ...
         64 64 64];

  map = map/255;

  tmp = colormap_helper(map, N);

% ----------------------------------------------------------------------
	
	cmap = tmp;						% outputing to cvec level #
	
end
