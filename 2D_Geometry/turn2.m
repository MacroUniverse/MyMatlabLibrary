%平面上的点逆时针旋转theta角
function [x1,y1]=turn2(x,y,theta)

x1=zeros(size(x));
y1=zeros(size(y));

s=sin(theta); c=cos(theta);
M=[c, -s; s, c];

xy=M*[x(:)'; y(:)'];
x1(:)=xy(1,:);
y1(:)=xy(2,:);

end