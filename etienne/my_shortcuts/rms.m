function out = rms(X,Y)
%
% Computes the temporal root-mean-square of 1 variable or of a
% difference of 2 variables.
%
% That is,
%
% out = sqrt( mean( X*X ))  or sqrt( mean( (X-Y)*(X-Y) ) )
%
% INPUT:      X     , variable 1 (Ntime x Nlat x Nlon)
%             Y     , (optional) variable 2 (same dims)
% 
% OUTPUT:     out   , desired rms (Nlat x Nlon)
%             
% ====================================================================

  % taking care of the optional second argument
  if nargin==2
    X = X-Y; 
  end

  % very simply using sqmean.m 
  out = sqrt(sqmean(X.^2));

end
