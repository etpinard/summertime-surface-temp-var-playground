function map = winter(varargin)
%WINTER  Blue-green colormap
%
% Examples:
%   map = winter;
%   map = winter(len);
%   B = winter(A);
%   B = winter(A, lims);
%
% Similar to MATLAB's winter function, but also able to return a concise
% colormap table.
%
% The function can additionally be used to convert a real-valued array into
% a truecolor array using the colormap.
%
% IN:
%   len - Scalar length of the output colormap. If len == Inf the concise
%         table is returned. Default: len = size(get(gcf, 'Colormap'), 1);
%   A - Non-scalar numeric array of real values to be converted into
%       truecolor.
%   lims - 1x2 array of saturation limits to be used on A. Default:
%          [min(A(:)) max(A(:))].
%
% OUT:
%   map - (len)x3 colormap table.
%   B - size(A)x3 truecolor array.

% $Id: winter.m,v 1.2 2009/04/10 13:00:33 ojw Exp $
% Copyright: Oliver Woodford, 2009
%
%map = [0 0 1; 0 1 0.5];
%
% ----------------------------------------------------------------------

% My modification (06/14)
map = [0 0 1; 143/255 188/255 143/255; 0 1 0.1; ... 
  189/255 183/255 107/255; 1 1 0.5];

% My modification (06/14) take 2
map = [0 0 1; 0 1 0.6; 1 1 0.5];

map = colormap_helper(map, varargin{:});
