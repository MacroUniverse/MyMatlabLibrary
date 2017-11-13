%产生X-Y平面上圆环N（一个数）点点阵数组，半径为R(列向量)；
%产生X-Y平面上圆环N（一个数）点点阵数组，半径为R(列向量)；
%输出size(x)=[length(R),N]
%       size(y)=[length(R),N]
function  [x,y,z]=ringXY(R,N)
th= (1:N)/(N-1)*2*pi;
x=R*cos(th);%size(x)=[length(R),N]
y=R*sin(th); %size(y)=[length(R),N]
z=zeros(size(x));