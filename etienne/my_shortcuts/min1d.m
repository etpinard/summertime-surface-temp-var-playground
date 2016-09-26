function out = min1d(X)
%
% A function that find the minimum value in a 3D or 2D array
%	
%
% INPUT:				X			, array in question
%
% OUTPUT:				out		, minimum value
% ===================================================================


		% call make1d.m
	tmp = make1d(X);

		% find the minimum value and output
	out = min(tmp);

end
