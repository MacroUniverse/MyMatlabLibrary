%用fill画出一个圆环/多边形(默认绿色)
%p0是圆环中心, a是水平半长轴, b是数值半长轴, thickness是长轴短轴截面的宽度
%N是多边形的变数,默认365;
%用FinePlot函数来实现处处等宽
function FineRing(p0,a,b,thickness,N,theta,varargin)
if ~exist('N','var')
    N=365;
end
t=linspace(pi/N,2*pi-pi/N,N);
x=zeros(1,N+2); y=x;
x(2:end-1)=p0(1)+a*cos(t);
y(2:end-1)=p0(2)+b*sin(t);
x(1)=x(2); x(end)=x(1);
%旋转
if exist('theta','var')
   [x,y]=turn2(x,y,theta);
end
if nargin>5
    FinePlot([x',y'],thickness,'FaceColor','g',varargin{:});
else
    FinePlot([x',y'],thickness,'FaceColor','g');
end
end