function out = nansync(X,Y)
%
%	Synchronizes in 2 arrays of the same dimensions.
%
%	Non-NaN values present in Y at grid locations where X has a NaN
% are susbtituted from Y into X.
%
% INPUT:				X   			, base array (ndims <=3)
%               Y         , substitution array
%
% OUTPUT:       out       , nan-synchronized array
% ===================================================================

  
		% first find size of X (up to 3 dimensions)
	[N1,N2,N3] = size(X);
  
    % exit if not of the same size
  if (N1 ~= size(Y,1)) || (N2 ~= size(Y,2)) || (N3 ~= size(Y,3))
    disp('!!! Invalid argument: arrays do not have same size');
    return
  end

    % initialize the out array to X (the base array)
  tmp = X;

    % separate NaN entries (0) and non-NaN entries (1)
  X_sep = ~isnan(X);
  Y_sep = ~isnan(Y);        % both have same dimensions

    % take difference
  diff_sep = Y_sep - X_sep;

  %% So, entries corresp. to diff_sep= +/- 1 will be synchronized
  %% diff_sep =  1 --> Y  has non-NaN value --> To substitute
  %% diff_sep = -1 --> X  has non-NaN value --> do nothing!

    % find the correspond. indices for the substitution
  sub_i = find(diff_sep==1);

    % make the substitution
  tmp(sub_i) = Y(sub_i);
  

    % output the resulting array
  out = tmp;

end
