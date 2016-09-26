function out = max1d(X)
%
% A function that find the mean value in a 3D or 2D array
%	
%
% INPUT:				X			, array in question
%
% OUTPUT:				out		, mean value
% ===================================================================


		% call make1d.m
	tmp = make1d(X);

		% find the mean value and output (using nanmean)
	out = nanmean(tmp);

end
