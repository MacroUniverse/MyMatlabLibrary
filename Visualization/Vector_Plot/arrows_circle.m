%画一圈箭头, 指向各个角度
close all; clear all;
N=8;
t=linspace(0,2*pi*(1-1/N),N)';
p(:,2)=sin(t); p(:,1)=cos(t);

setfigure blank; axis([-1 1 -1 1]);
thickness=0.1;
for ii=1:N
    FineArrow(p(ii,:)/2,p(ii,:),thickness,3*thickness,3*thickness);
end
r=0.4;
FineRing([0 0],r,r,0.05,500,0,'facecolor','r');