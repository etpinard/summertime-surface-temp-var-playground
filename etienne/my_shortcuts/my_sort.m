function [I_sort,I_high,I_low] = my_sort(X,Nthres);
%
% Sort 3D array in the first column (time) and find indices 
%	(consistent with input array).
%
%
% INPUT:			X  	     , 3D array to sort in first dimension
%             Nthres   , (optional) number threshold to splitting 
%                       output indices into 'high' and 'low'.
% 
% OUTPUT:		  I_sort  , indices of sorted array such that 
%                       X(I_sort) = sort(X)
%             I_high  , indices of highest $Nthres values in 'X'
%             I_low   , "" of lowest ($N1 - $Nthres) values in 'X'
%							
% ====================================================================


  % find size of 'X'
  [N1 N2 N3] = size(X);

  % reshape 'X' into a 2d array  
  X2d = reshape(X,[N1,N2*N3]);

  % sort 'X' in the first dimension and get indices
  [X_sorted2d,index2d] = sort(X2d,1);
  
  % correct 'index2d' to match 'X'
  index2d = index2d + repmat(0:N2*N3-1,N1,1)*N1;
  
  % reshape 'index2d' (and 'X_sorted2d') back to 3D
  index = reshape(index2d,[N1,N2,N3]);
  X_sorted = reshape(X_sorted2d,[N1,N2,N3]);

  % just a test ...
%  isthesame(X_sorted,X(index));

% ----------------------------------------------------------------------

  % output I_sort (N1 x N2 x N3)
  I_sort = index;

  % split 'I_sort' into 'high' and 'low' indices
  if nargin==2 && Nthres<N1

    high = [N1-Nthres+1:N1];
    low = [1:(N1-Nthres)];

    I_high = I_sort(high,:,:);
    I_low = I_sort(low,:,:);

  end

end
