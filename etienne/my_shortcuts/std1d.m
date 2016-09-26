function out = max1d(X)
%
% A function that find the std value in a 3D or 2D array
%	
%
% INPUT:				X			, array in question
%
% OUTPUT:				out		, std value
% ===================================================================


		% call make1d.m
	tmp = make1d(X);

		% find the std value and output (using nanstd)
	out = nanstd(tmp);

end
