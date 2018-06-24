%求平面两射线的交点
%平面射线的格式是l=[m, n,theta]; 其中[m,n]是平面直角坐标, theta是与x轴的夹角
%size(l1)=size(l2)=[N,3];
function [p,badmark]=l22p(l1,l2)

%如果两条线平行或者重合, 返回p=[nan,nan];
mark=l1(:,3)~=l2(:,3);
e1x=cos(l1(mark,3)); e1y=sin(l1(mark,3)); %l1的单位矢量
e2x=cos(l2(mark,3)); e2y=sin(l2(mark,3)); %l2的单位矢量
p1x=l1(mark,1); p1y=l1(mark,2); p2x=l2(mark,1); p2y=l2(mark,2);
t1=(-(p2x-p1x).*e2y+e2x.*(p2y-p1y))./(-e1x.*e2y+e2x.*e1y);
p(mark,2)=p1y+e1y.*t1;
p(mark,1)=p1x+e1x.*t1;
badmark=~mark;
p(badmark,[1 2])=nan;

end