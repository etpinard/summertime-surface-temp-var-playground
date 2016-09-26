function cmap = color_mydusk(cvec)
%
% My version of the `dusk' color_map downloaded from the MATLAB file
% exchange website, in ~/proj/file_exchange/ .
%
% INPUT:		cvec		, contour level vector
% OUTPUT:		cmap		, normalized RGB color map
% ======================================================================

  Ncvec = length(cvec);
  
  tmp = dusk(Ncvec+1);			
  tmp = flipud(tmp(2:Ncvec,:));			
	
% ----------------------------------------------------------------------
	
	cmap = tmp;						% outputing to cvec level #
	
end
