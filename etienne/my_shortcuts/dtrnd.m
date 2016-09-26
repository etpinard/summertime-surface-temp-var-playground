function [XX,DXbar,Xbart] = dtrnd(xx,xbar)
%
% Generalization of MATLAB's detrend function for 3D arrays which
% includes NaN entries.
% 
% More precisely, this function removes the least-squares linear fit
% of `xx' (typically the anomaly field with the annual cycle removed)
% to get `XX' and its trend `DXbar'.
%
% If `xbar' (from anomaly.m) is specified, `Xbart' is computed by
% adding `DXbar' to `xbar'.
%
% So, 
%
% X(time,lat,lon) = Xbar(month,lat,lon) + DXbar(time,lat,lon)
%                           + XX(time,lat,lon) .
%
% or X(time,lat,lon) = Xbart(time,lat,lon) + XX(time,lat,lon)
%
%
% INPUT:		xx     , input array (time in first dimension)
%           xbar   , (OPT.) clim. monthly means (if xx comes from
%                           anomaly.m)
% 
% OUTPUT:		XX     , detrended array
%           DXbar  , trend
%           Xbart  , trend + clim. monthly mean (requires xbar)
%
%
% *** Maybe a should split this is 2: 1 function only for generalizing
%     detrend and 1 function to link to anomaly.m.
%
% *** Should detrend only on a year-to-year basis? Afterall, we
%     already took out the annual cycle.
% ====================================================================

   
  % get input array dims (time in first dimension, up to 3D for now)
  Ntime = size(xx,1);
  N2 = size(xx,2);
  N3 = size(xx,3);
  N = N2*N3;

  % reshape input array to 2D 
  xx2d = reshape(xx,Ntime,N);

  % build time vector 
  tt = [1:Ntime]';

  % intialize DXbar array with NaN (important!)
  DXbar = repmat(NaN,Ntime,N);
  
  % loop trough all locations 
  % Yes, I don't think there is a better way unfortunately.

  for i=1:N

    % squeeze xx at grid point $i
    xx2d1 = sqz(xx(:,i));

    % find indices of non-NaN entries
    good = find(~isnan(xx2d1));
    
    % linear fit ('1') coefficients using only non-NaN entries
    if ~isempty(good)
      tmp = polyfit(tt(good),xx2d1(good),1);
    else
      continue;
    % NaN entries are unchanged from the initialization
    end
  
    % fill linear trend in DXbar
    DXbar(good,i) = polyval(tmp,tt(good));

  end

  % reshape DXbar to same dimension as xx
  DXbar = reshape(DXbar,[Ntime,N2,N3]);

  % detrend xx
  XX = xx - DXbar;

  % add DXbar to xbar (if given)
  if nargin ==2 && nargout==3
    Xbart = DXbar + xbar; end


end
