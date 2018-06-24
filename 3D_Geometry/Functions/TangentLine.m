%求曲线的切向量，即点线的下一条线段与上一条的单位角平分线向量
%允许多条曲线，每条分别占x,y,z矩阵的一列
%输入中x,y,z矩阵的格式：size(x)=size(y)=size(z)=[每条线的点数,线的条数]
%输出的矩阵格式与输入保持一致
%每条曲线的端点切线就是端点所在的线段

function [dx,dy,dz]=TangentLine(x,y,z)


%产生线上相邻两点的向量矩阵:

dx=diff(x);dy=diff(y);dz=diff(z); %分别少了一行，需要在下面复制一行

LEN1=length(x(:,1));  %x的第一维度长度（点数）
LEN2=length(x(1,:));  %x的第二维度长度（线数）

dx=cat(1,dx,dx(end,:));
dy=cat(1,dy,dy(end,:));
dz=cat(1,dz,dz(end,:)); %在最后复制一行

%(dx,dy,dz)化为单位向量:
dL=sqrt(dx.^2+dy.^2+dz.^2);
dx=dx./dL;dy=dy./dL;dz=dz./dL;

%非两端的向量取其前后向量的矢量和：
dx(2:LEN1-1,1:LEN2)=dx(1:LEN1-2,1:LEN2)+dx(2:LEN1-1,1:LEN2);
dy(2:LEN1-1,1:LEN2)=dy(1:LEN1-2,1:LEN2)+dy(2:LEN1-1,1:LEN2);
dz(2:LEN1-1,1:LEN2)=dz(1:LEN1-2,1:LEN2)+dz(2:LEN1-1,1:LEN2);

%(dx,dy,dz)化为单位向量:
dL=sqrt(dx.^2+dy.^2+dz.^2);
dx=dx./dL;dy=dy./dL;dz=dz./dL;

                                            