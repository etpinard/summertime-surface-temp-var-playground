function rg = ssn_rg(X,opt,nrm)
%
% Function that computes the (two-sided) seasonal cycle range
%  for a Nmonth x Nlat x Nlon variable
%
% By default August minus June (in the NH) is computed
%
% with `opt'='july' July minus June (in the NH) is computed
%
% with `nrm'='norm' the seasonal cycle range is normalize by the
% summertion mean of X.
%
% INPUT:			X    , input Nmonth x Nlat x Nlon variable
% 
% OUTPUT:		  rg   , Nlat x Nlon seasonal cycle range
%							
% ====================================================================
 
  % load Nmonth
  load('global.mat','Nmonth');

  if size(X,1) ~= Nmonth
    disp('$$$ Error: input must be Nmonth x Nlat x Nlon')
    return
  end

  % Very simply, compute differences, then squeeze
  
  if nargin>=2 && strcmp(opt,'july')
    rg = sqz(X(2,:,:) - X(1,:,:));
  else
    rg = sqz(X(3,:,:) - X(1,:,:));
  end

  % normalized by Xbarbar if asked
  
  if nargin==3 && strcmp(nrm,'norm')
    rg = rg./sqmean(X);
  end

end
