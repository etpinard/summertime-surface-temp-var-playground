function err = bias(X,Xtrue)
%
% Function that compute relative two-sided error of some X (3D or 2D)
% with respective to its "true" value Xtrue.
%
% That is,
%
% err = (X - Xtrue)/Xtrue
%
% (new!) uses `makenan.m' to remove grid points with Xtrue=0.
%
% INPUT:			X		 	, erroneous field (2D or 3D)
%             Xtrue , true field (same dimension as X)
% 
% OUTPUT:		  err   , relative two-sided error	
%							
% ====================================================================


  % make points with Xtrue=0 NaNs.
  den = makenan(Xtrue,'==0');

  % relative error
  err = (X - Xtrue)./den;

end
