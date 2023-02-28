%画一条线段, 精确控制直线的粗细
%用Fill函数实现
%从左到右的直线, 左上角是P1, 顺时针命名, 左下角是P2.
function FineLine(Pstart,Pend,thickness)
L=vmag(Pend-Pstart);
if nargin==2 %默认粗细
    thickness=L*0.005;
end
P=zeros(4,2);
P([1 4],1)=0; P([2 3],1)=L; %X坐标
P([1 2],2)=thickness/2; P([3 4],2)=-thickness/2;
%绕原点旋转线段; 
theta=atan2(Pend(2)-Pstart(2),Pend(1)-Pstart(1));
[P(:,1),P(:,2)]=turn2(P(:,1),P(:,2),theta);
%平移线段
P(:,1)=P(:,1)+Pstart(1); P(:,2)=P(:,2)+Pstart(2);
Fill(P,'k','EdgeColor','none');
end
