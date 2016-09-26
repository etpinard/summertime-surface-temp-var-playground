function out = addsheet(in,to_add1,to_add2,to_add3)
%
% Add sheet(s) to an existing 2D or 3D array using `cat' 
% and `permute',
%
% All input arrays must be of the same dimensions.
%
%
% INPUT:		in     , existing array 
%           to_add[1-3] , input sheet  (up to 3 for now)
% 
% OUTPUT:		out   , output array with extra sheet
% ====================================================================


  % concatenate `to_add1' with `in' in the 3rd dimension
  tmp = cat(3,in,to_add1);

  % if given add `to_add2'
  if nargin>=3
    tmp = cat(3,tmp,to_add2);
  end

  % if given add `to_add3'
  if nargin==4
    tmp = cat(3,tmp,to_add3);
  end

  % permute dimensions such that the sheet dimension be in the 1st
  % index, only works for 2D or 3D inputs ...
  tmp = permute(tmp,[3,1,2]);

  % output 
  out = tmp;

end
