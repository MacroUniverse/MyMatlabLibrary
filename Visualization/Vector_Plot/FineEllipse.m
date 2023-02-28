%画实心椭圆
%用fill函数实现, 默认颜色是红色
%p0是几何中心, a是x方向半长轴, b是y方向半长轴, N是线段的个数

%Fine系列的作图函数建议先用setfigure('blank')生成空白画板.

function FineEllipse(p0,a,b,N,varargin)
t=linspace(0,2*pi,N+1); t=t(1:end-1);
x=p0(1)+a*cos(t); y=p0(2)+b*sin(t);
if nargin==3
    N=365;
end
if nargin<=4
    fill(x,y,'r','EdgeColor','none');
else
    fill(x,y,'r','EdgeColor','none',varargin);
end
end