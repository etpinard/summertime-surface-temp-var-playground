function [alpha,X0] = regrs(X,Y,Nmonth)
% 
% A function that regresses X (3D Ntime x Nlat x Nlon) onto Y
% (of the same dimensions) using orthogonal projections assuming
% mean have been removed.
%
% That is, we set
%
%   X = X0 + alpha*Y, where <X_0,Y> by definition.
% 
% Then, alpha is simply <X,Y>/<Y,Y> and X0 = X - alpha*Y.
% The regression parameter alpha is computed month-to-month.
%
% And please note the sign; here alpha is positive if X and Y are
% positively correlated.
%
% INPUT:    X       , variable to regress (or parameterize)
%           Y       , projection varible      
%           Nmonth  , # of months (if [], taken form 'global.mat')
%
% OUTPUT:   alpha   , regression parameter (Nmonth x Nlat X Nlon)
%           X0      , orthogonal residual (Ntime x Nlat x Nlon)
%           Alpha   , expanded regress. param. (Ntime x Nlat X Nlon)
%                         (OBSOLETE! use xmonth.m instead)
% ====================================================================

  % load Nyear, Nlat, Nlon  via global.mat
%  load('global.mat','Nyear','Nlat','Nlon');

  % get 'Nmonth', if undefined
  if nargin<=2
    load('global.mat','Nmonth');
  end

  % 'Ntime' is total number of time entries in the sample
  Ntime = size(X,1);
%  Ntime = Nmonth*Nyear;
  
  % 'Nyear' is number of years in the sample
  Nyear = Ntime/Nmonth;

  % for compatibility in ./valid_to_obs/, get Nlat, Nlon
  Nlat = size(X,2);
  Nlon = size(X,3);
  N = Nlat*Nlon;        % # of grid points

  % reshaping X and Y to 2 dimensions (time,location)
  X2d = reshape(X,Ntime,N);
  Y2d = reshape(Y,Ntime,N);
      
  % pre-allocating alpha, the regression parameter
  % and X02d, the residual. 
  alpha = repmat(NaN,Nmonth,N); 
  X02d = repmat(NaN,Ntime,N);
  
    % Here, we include the annual cycle by computing alpha
    % on a month-to-month basis using a sample of
    % $Nyear year for each month.
  
    %%% maybe make an option to not include the annual cycle ...
  
  for i=1:N     % looping through the locations
    
      % X and Y at location i for $Ntime time enties
    tmpX = X2d(:,i);
    tmpY = Y2d(:,i);
  
      % Reshaping in order to take clim. mean
    tmpXt = reshape(tmpX,Nmonth,Nyear); 
    tmpYt = reshape(tmpY,Nmonth,Nyear); 
  
      % means in MATLAB works column-wise
    tmpXt = tmpXt';       
    tmpYt = tmpYt';       % both Nyear x Nmonth
      
      % computing alpha for $Nmonth months
    alpha(:,i) = nanmean(tmpXt.*tmpYt)./nanmean(tmpYt.*tmpYt);
  
      % expanding alpha to $Ntime
    tmpalpha = repmat(alpha(:,i),Nyear,1);
  
      % computing the residual
    X02d(:,i) = tmpX - tmpalpha.*tmpY;
  
  end; 
  
    % reshaping the regress. param. to 3D
  alpha = reshape(alpha,Nmonth,Nlat,Nlon);  % (Nmonth x Nlat x Nlon)
  
    % reshaping the residual to 3D
  X0 = reshape(X02d,Ntime,Nlat,Nlon);       % (Nmonth x Nlat x Nlon)
  
    % expending alpha to (Ntime x Nlat x Nlon) -- use xmonth.m instead
  %Alpha = repmat(alpha,Nyear,1);         
  
end
