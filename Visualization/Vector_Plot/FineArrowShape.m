%精确画出箭头
%用fill函数精确控制形状
%Pstart=[x0,y0]起始坐标  Pend=[x1,y1]终止坐标
%以下自变量可以省略, 采用默认值.
%LineWidth线条粗细; Ltriangle三角形长度; Htriangle三角形宽度
%一个标准的从左到右的箭头(长方形加三角形), 共有7个点, 键头尖部为P(1,:), 逆时针命名, 最后回到尖部P(8,:)

%先用setfigure('blank')生成空白的画图板

function info=FineArrowShape(Pstart,Pend,LineWidth,Ltriangle,Htriangle)

L=vmag(Pend-Pstart); %箭头长度
if nargin==2 %默认形状
    LineWidth=L*0.005;
    Ltriangle=L*0.04;
    Htriangle=L*0.02;
end

%先画从原点到[L,0]的箭头.
P=zeros(8,2); 
P([4 5],1)=0;  P([1 8],1)=L;  P([2 3 6 7],1)=L-Ltriangle; %各点的x坐标
P([3 4],2)=LineWidth/2; P([5 6],2)=-LineWidth/2; P(2,2)=Htriangle/2; P(7,2)=-Htriangle/2; %各点的y坐标
P=P(1:7,:);

%绕原点旋转箭头; 
theta=atan2(Pend(2)-Pstart(2),Pend(1)-Pstart(1));
[P(:,1),P(:,2)]=turn2(P(:,1),P(:,2),theta);
%平移箭头
P(:,1)=P(:,1)+Pstart(1); P(:,2)=P(:,2)+Pstart(2);

%画箭头
Fill(P,'k','EdgeColor','none');

%输出箭头形状配置
info=num2cell([LineWidth,Ltriangle,Htriangle]);
end