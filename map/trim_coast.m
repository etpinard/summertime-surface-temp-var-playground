function tc=trim_coast(c,tol1,tol2);
%
%  trims coastline by inserting NaN's where there are large lat or lon gaps
%  that were caused by cropping the map
%
% Known Bugs: if there are only two line segments this code will bomb
% 

if nargin==1; tol1=1.6;tol2=6.1;end

fl=find( ( abs(diff(c(:,1))) > tol1 ) | abs(diff(c(:,2))) > tol2 );

if length(fl)==0,tc=c;return;end
disp(length(fl))

tc = c(1:fl(1),:);                                
for k = 1:length(fl)-1;  
  tc=[tc; [NaN, NaN]; c((fl(k)+1):fl(k+1,:),:)];
end
tc=[tc; [NaN, NaN]; c((fl(length(fl))+1):length(c),:)];


