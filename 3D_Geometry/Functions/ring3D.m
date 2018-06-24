%在指定的点M周围画以A向量为法向量的圆环
%半径为|A|,圆环共N个元素
%M是三列坐标数组
%size(A)=size(M),N是一个数
%输出三个数组,每个数组的每行是一个圆环，有N个元素，列长度同输入


function [x2,y2,z2]=ring3D(M,A,N)

if length(M)~=length(A)
error(' length(M)~=length(A)')
end

%产生length(R)个XY平面上的圆环，每行一个:
Ax=A(:,1);Ay=A(:,2);Az=A(:,3);
Mx=M(:,1);My=M(:,2);Mz=M(:,3);
R=sqrt(Ax.^2+Ay.^2+Az.^2);
[x0,y0,z0]=ringXY(R,N);

LEN=length(Mx);

x1=zeros(size(x0));
y1=x1;
z1=x1;

for i=1:LEN
[x1(i,:),y1(i,:),z1(i,:)]=turnA(x0(i,:),y0(i,:),z0(i,:),A(i,:));
end

x2=x1+repmat(Mx,[1,N]);
y2=y1+repmat(My,[1,N]);
z2=z1+repmat(Mz,[1,N]);

