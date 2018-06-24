%语法1: V1=vturn(V,D1,D2)
%把空间矢量由D1方向绕原点转到D2方向

%语法2: V1=turn(V,A,theta)
%把空间矢量点绕原点以A方向为轴逆时针转动theta角

%一次调用处理一个向量;( 如果处理多个向量, 可以用 P1=turn(P,...,...);

%numel(V)=numel(D1)=numel(D2)=3
%numel(theta)=1
%根据第三个自变量的长度决定算法
%需要用到自编函数vunit


function V1=vturn(V,A,theta)

if numel(V)~=3
    error('numel(V)~=3')
elseif numel(A)~=3
    error('numel(A)~=3') 
end

if numel(theta)==3
    D1=vunit(A);
    D2=vunit(theta);
    A=cross(D1,D2);
    C=dot(D1,D2);
    S=sqrt(1-C^2);
    
elseif numel(theta)==1
    C=cos(theta);
    S=sin(theta);

else
    error('numel(theta)~=1 or numel(D2)~=3'); 
end

A0=vunit(A);
Ax=A0(1);
Ay=A0(2);
Az=A0(3);
C1=1-C;

M=...
[
C1*Ax*Ax+C      C1*Ax*Ay-Az*S   C1*Ax*Az+Ay*S
C1*Ay*Ax+Az*S  C1*Ay*Ay+C       C1*Ay*Az-Ax*S
C1*Az*Ax-Ay*S   C1*Az*Ay+Ax*S  C1*Az*Az+C 
];

V1=zeros(size(V));
V1(:)=M*V(:);

end


