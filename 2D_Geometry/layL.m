function [X1,Y1]=layL(X,Y)
[e l]=linfit(X,Y);
c=e(2); s=e(1);
M=[c,-s; s,c];
temp=M*[X(:)'; Y(:)'];
X1=zeros(size(X)); Y1=zeros(size(Y));
X1(:)=temp(1,:); Y1(:)=temp(2,:)-l;
if nargout==0
   figure
   scatter(X1,Y1,3,'filled');
clear X1 Y1
end
end