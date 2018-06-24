%格式(flag=0)
%[x1,y1,z1]=turn(x,y,z,A,theta)  把空间点绕原点以A方向为轴逆时针转动theta角
%[x1,y1,z1]=turn(x,y,z,D1,D2)  把空间点由D1方向绕原点转到D2方向
%    numel(x)=numel(y)=numel(z)
%    numel(D1)=numel(D2)=numel(A)=3
%    numel(theta)=1

%格式(flag=1).
%P1=turn(P,A,theta) 把空间点绕原点以A方向为轴逆时针转动theta角
%P1=turn(P,D1,D2)  把空间点由D1方向绕原点转到D2方向
%size(P)=size(P1)=[N,3]


function [x1,y1,z1]=turn(x,y,z,A,theta)

%格式检查
flag=0; %flag=0表示格式0, flag=1表示格式1
if nargout==1 && nargin==3  %格式检查
    A=y; theta=z;
    y=x(:,2); z=x(:,3); x=x(:,1);
    flag=1;
elseif numel(x)~=numel(y)||numel(y)~=numel(z) %格式0要求xyz元素个数相同即可
    error('numel of x,y,z is not equal')
end

if length(A(:))~=3 %两种格式都要求A是一个矢量
    error('length A is not 3');
end

if numel(theta)==3 %
    D1=vunit(A);
    D2=vunit(theta);
    A=cross(D1,D2);
    C=dot(D1,D2);
    S=sqrt(1-C^2);
elseif numel(theta)==1
    C=cos(theta);
    S=sin(theta);
else
    error('numel(theta)~=1 or numel(A2)~=3'); 
end

A0=vunit(A);
Ax=A0(1); Ay=A0(2); Az=A0(3);
C1=1-C;

M=...  %见<普通物理索引>旋转矩阵
[
C1*Ax*Ax+C      C1*Ax*Ay-Az*S   C1*Ax*Az+Ay*S
C1*Ay*Ax+Az*S  C1*Ay*Ay+C       C1*Ay*Az-Ax*S
C1*Az*Ax-Ay*S   C1*Az*Ay+Ax*S  C1*Az*Az+C 
];

XYZ1=M*[x(:)';y(:)';z(:)'];

if flag==0 %原格式
x1=zeros(size(x));
y1=zeros(size(y));
z1=zeros(size(z));

x1(:)=XYZ1(1,:);
y1(:)=XYZ1(2,:);
z1(:)=XYZ1(3,:);
else  %新格式
   x1=XYZ1';
   y1=[]; z1=[];
end

end


