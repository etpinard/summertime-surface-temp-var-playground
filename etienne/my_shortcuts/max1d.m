function out = max1d(X)
%
% A function that find the maximum value in a 3D or 2D array
%	
%
% INPUT:				X			, array in question
%
% OUTPUT:				out		, maximum value
% ===================================================================


		% call make1d.m
	tmp = make1d(X);

		% find the maximum value and output
	out = max(tmp);

end
