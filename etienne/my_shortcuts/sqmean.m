function out = sqmean(X)
%
% A function that computes the mean (using nanmean) of
% a 3D array X and squeeezes it down to a 2D array.
%
% INPUT:				X			, 3D array to be averaged
%
% OUTPUT:				out		, 2D averaged array
% ===================================================================

		% very simply ...
	out = squeeze(nanmean(X));

end
