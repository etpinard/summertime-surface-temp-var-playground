function [out,imonth] = ddt(X)
%
% A function that computes the time derivative d/dt of the variable X
% using a first-order (linear) approximation.
%
% This function is intended for summer monthly data of $Nmonth time
% entry per summer. The wrap-around problem is not adress, instead the 
% output function has $Ntime/$Nmonth*($Nmonth-1) time entries.
%
% INPUT:      X     , variable in question X(time,lat,lon)
%                     it can be either Ntime x Nlat x Nlon or
%                     Nmonth X Nlat x Nlat.
% 
% OUTPUT:     out    , time derivative of X. It has
%                      $Ntime/$Nmonth*($Nmonth-1) time entries
%             imonth , indices of the current month
% ====================================================================
  
    % load global.mat
  load('global.mat','Ntime','Nyear','Nmonth');

    % 1 month is 30 days
  secinday = 24*60*60;
  dt = 30*secinday;

    % -) base indices for 1 summer
  i0 = [1:Nmonth-1];      % current index
  i1 = [2:Nmonth];        % stepping index
        
    % # number of time entries
  N = Nyear*(Nmonth-1);
  
    % -) looping to build indices for all years
  if Nyear~=1;
  
      % pre-allocation
    I0 = ones(1,N);
    I1 = ones(1,N);
    
      % looping through the years
    for j=0:Nyear-1

        % indices of I0, I1 vectors
      ij = [1:Nmonth-1]+(Nmonth-1)*j;
      
      I0(ij) = i0+repmat(Nmonth*j,1,Nmonth-1);
      I1(ij) = i1+repmat(Nmonth*j,1,Nmonth-1);
    
    end
    
  else    % if Nyear==1

    I0 = i0; I1 = i1;

  end

  % The simple first order approx to dX/dt
  out = (X(I1,:,:)-X(I0,:,:))/dt;

  % Outputting also the indices of the current month
  imonth = I0;

end
