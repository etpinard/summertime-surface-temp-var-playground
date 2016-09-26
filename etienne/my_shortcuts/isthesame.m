function out = isthesame(X,Y)
%
% A function that compute the distance between each 
% element of X and Y (of the same size) and outputs the maximum
% element in the difference array.
%
% Note that the isequal command does essentially the same thing
% but it is more susceptible to runoff error ...
%
%
% INPUT:        X,Y   , 2 arrays to compare (of the same size)
%
% OUTPUT:       out   , maximum distance
% ===================================================================

  % very simply ---> using make1d.m
  tmp = nanmax(abs(make1d(X-Y)));

  % Output yes or no to screen
  if tmp<eps;
    
    disp('Yes ... X and Y are the same!');

  else

    disp('No ... X and Y are not the same');

  end

  % assign the difference
  out = tmp;

end
