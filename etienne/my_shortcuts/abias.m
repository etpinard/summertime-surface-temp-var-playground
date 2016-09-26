function err = abias(X,Xtrue)
%
% Function that compute relative one-sided error of some X (3D or 2D)
% with respective to its "true" value Xtrue.
%
% That is,
%
% err = | (X - Xtrue)/Xtrue |
%
% INPUT:			X		 	, erroneous field (2D or 3D)
%             Xtrue , true field (same dimension as X)
% 
% OUTPUT:		  err   , relative one-sided error	
%							
% ====================================================================


    % very simply
  err = abs((X - Xtrue)./Xtrue);

end
