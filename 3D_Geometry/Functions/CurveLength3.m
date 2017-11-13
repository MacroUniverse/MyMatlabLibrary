%计算曲线每点到第一点的路程
%M的格式：M(第m个点，第n条)

function L=CurveLength3(x,y,z)
dx=diff(x);dy=diff(y);dz=diff(z);

LEN1=length(x(:,1));
LEN2=length(x(1,:));

dx=cat(1,zeros(1,LEN2),dx);
dy=cat(1,zeros(1,LEN2),dy);
dz=cat(1,zeros(1,LEN2),dz);  %产生线上相邻两点的向量矩阵

dL=sqrt(dx.^2+dy.^2+dz.^2);%产生线上相邻两点的距离矩阵

L=zeros(LEN1,LEN2);
SumL=zeros(1,LEN2);%预置循环中矩阵规格

for i=1:LEN1
     SumL=SumL+dL(i,:);%线上第i个点到第一个点的路程
     L(i,:)=SumL;
end
    
    