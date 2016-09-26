function c = r2b(m)
% R2B   Red to Blue colormap with white in the middle


%Joe Barsugli
if nargin < 1,m=64;end
c = sat2('r','b',1.5,m);
