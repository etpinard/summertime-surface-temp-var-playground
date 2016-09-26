function [out,Nout] = make1d(X)
%
% A function that turns X (3D or 2D for now) into a 1D vector.
%
% INPUT:				X			, array to be reshaped
%
% OUTPUT:				out		, 1D vector
%								Nout	, length of 1D vector
% ===================================================================


		% first find size of X (up to 3 dimensions)
	[N1,N2,N3] = size(X);

		% reshaping to 1 dimension
	Nout = N1*N2*N3;
	out = reshape(X,Nout,1);

	
	%% Maybe try implement this ...
  %% Computing the number of elements in X (hence Y)
	%Narray = size(X);
	%dim = length(Narray);
	%N = 1; 
	%for i=1:dim; 
	%	N = N*Narray(i); end

end
