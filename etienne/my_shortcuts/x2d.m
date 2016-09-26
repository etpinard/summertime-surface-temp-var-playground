function out = x2d(X,N)
%
% A function that turns X (Nlat x Nlon) into 
% (Nmonth x Nlat x Nlon) by copying its entries onto the $Nmonth
% sheets.
%
% For example, Xbar.*x2d(sqmean(Xbar)) will work!
%          or, XX.*xmonth(x2d(sqmean(Xbar))) also!
%
% INPUT:        X     , (Nlat x Nlon) array to be repmat'd
%               N     , number of sheets (3 by default)
%
% OUTPUT:       out   , corresponding (Nmonth x Nlat x Nlon) array
% ===================================================================

% % load Nmonth, Nlat and Nlon via global.mat
% load('global.mat','Nmonth','Nlat','Nlon');

  % get dimensions
  Nmonth = 3;
  [Nlat,Nlon] = size(X);

  % default output
  if nargin<2
    
    % copying sheet by sheet ... there's gotta be a faster way!
    tmp = zeros(Nmonth,Nlat,Nlon);

    for j=1:Nmonth; 

      tmp(j,:,:) = X;

    end
  
  % optional output
  else

    tmp = zeros(N,Nlat,Nlon);

    for j=1:N; 

      tmp(j,:,:) = X;

    end

  end

    % outputting
  out = tmp;

end

