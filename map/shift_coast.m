% shifts coastline data so that it is cut along the greenwich meridian.

ll2=coast;
ll2(:,2)=rem(ll(:,2)+360,360);
fl=find(abs(diff(ll2(:,2)))>300);

ll3 = ll2(1:fl(1),:);                                
for k = 1:length(fl)-1;  
  ll3=[ll3; [NaN, NaN]; ll2((fl(k)+1):fl(k+1,:),:)];
end
ll3=[ll3; [NaN, NaN]; ll2((fl(length(fl))+1):length(ll2),:)];


