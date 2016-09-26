function c = sat2(c1,c2,gam,m,r);
%
% colormap of length m (default 64) that goes from c1 to white(gray) to c2.
% only the saturation of the colors is changed.
%
%
%   c1,c2  rgb colors that form the endpoints of the colormap (default [1 0 0] [0 0 1])
%   
%   gam (def 1.5)    ramping in saturation goes as i^gam i ramps linearly fron 0 to 1 and back to 0.
%
%   for even m the two middle values are nearly 1, for odd m, only the middle value is 1.

if nargin < 5, r=1;end
if nargin < 4, m=64;end
if nargin < 3, gam = 1.5;end
if nargin < 2, c1 = [1 0 0]; c2=[0 0 1];end

switch c1(1)
  case 'r'; c1 = [1 0 0];
  case 'g'; c1 = [0 1 0];
  case 'b'; c1 = [0 0 1];
  case 'y'; c1 = [1 1 0];
  case 'w'; c1 = [1 .6 0];
end
switch c2(1)
  case 'r'; c2 = [1 0 0];
  case 'g'; c2 = [0 1 0];
  case 'b'; c2 = [0 0 1];
  case 'y'; c2 = [1 1 0];
  case 'w'; c2 = [1 .6 0];
end

[h1 s1 v1]=rgb2hsv(c1);
[h2 s2 v2]=rgb2hsv(c2);

v=2*[0:(m-1)]/(m-1);
s = r*min(v,2-v)';

mf1 = floor(m/2);
mf2 = ceil(m/2);

%chsv= [  [h1*ones(mf1,1);h2*ones(mf2,1)] , (1-s).^gam , [v1*ones(mf1,1);v2*ones(mf2,1)] ];

chsv= [  [h1*ones(mf1,1);h2*ones(mf2,1)] , (1-s).^gam , s + (1-s).*[v1*ones(mf1,1);v2*ones(mf2,1)] ];


c = hsv2rgb(chsv);
