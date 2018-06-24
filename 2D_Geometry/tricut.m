%大三角形截成n^2个小三角形

function [i,j]=tricut(n)
i=zeros(3,n^2); j=i;
ii=1;
for a=1:n
for b=1:2*(n-a)+1;
if mod(b,2)==1%b为奇数
    i(:,ii)=[a-1, a-1, a];
    j(:,ii)=[(b+1)/2, (b-1)/2, (b-1)/2];
    ii=ii+1;
else %b为偶数
    i(:,ii)=[a-1, a, a];
    j(:,ii)=[b/2, b/2-1, b/2];
    ii=ii+1;
end
end
end
end