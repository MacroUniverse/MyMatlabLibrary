%精确控制plot函数的粗细
%用Fill函数来实现
%每一个线段的粗细都严格控制, 在线段交点处取两组平行线的交点.
%size(p)=[N,2];

%关于属性
%varargin是Fill(X,Y,varargin)里面的varargin
%颜色默认是蓝色, 如果改颜色, 在varargin中加入'FaceColor','颜色'

function FinePlot(p,d,varargin)
if ~exist('d','var')
    d=0.05;
end
N=size(p,1); %点的个数
%plot的每一个线段转换为射线
l=p22l(p(1:end-1,:),p(2:end,:));
%每一段射线左移和右移
lLeft=lmove(l,d/2); lRight=lmove(l,-d/2);
%求相邻线段的交点
pLeft=zeros(N,2); pRight=pLeft; 
[pLeft(2:N-1,:),badLeft]=l22p(lLeft(1:end-1,:),lLeft(2:end,:));
[pRight(2:N-1,:),badRight]=l22p(lRight(1:end-1,:),lRight(2:end,:));
%相邻两条线段平行的情况(交点取l2的起点)
pLeft(badLeft+1,:)=lLeft(badLeft+1,[1 2]); pRight(badRight+1,:)=lRight(badRight+1,[1 2]);
%补上第一点和最后一点
pLeft(1,:)=lLeft(1,[1 2]); pRight(1,:)=lRight(1,[1 2]);
temp=d/2*[-sin(lLeft(end,3)),cos(lLeft(end,3))];
pLeft(N,:)=p(N,:)+temp;
pRight(N,:)=p(N,:)-temp;
if nargin>2
    Fill([pLeft; flipud(pRight)],'b','EdgeColor','none',varargin{:});
else
    Fill([pLeft; flipud(pRight)],'b','EdgeColor','none');
end