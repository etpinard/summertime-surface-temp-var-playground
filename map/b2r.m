function c = r2b(m)
% B2R   Blue to Red colormap with white in the middle


%Joe Barsugli
if nargin < 1,m=64;end
c = sat2('b','r',1.5,m);
