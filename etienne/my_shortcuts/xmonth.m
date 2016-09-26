function out = xmonth(X,Nyear)
%
% A function that turns X (Nmonth x Nlat x Nlon) into
% (Ntime x Nlat x Nlon) by copying its entries.
%
% For example, XX.*xmonth(sig_X) will work!
% or X - xmonth(Xbar).
%
% INPUT:        X     , (Nmonth x Nlat x Nlon) array to be repmat'd
%               Nyear , # of years in sample
%
% OUTPUT:       out   , corresponding (Ntime x Nlat x Nlon) array
% ===================================================================

  if nargin==1
    % load Nyear via global.mat
    load('global.mat','Nyear');
  end

  % repmat Nyear times 
  out = repmat(X,Nyear,1);          

end
