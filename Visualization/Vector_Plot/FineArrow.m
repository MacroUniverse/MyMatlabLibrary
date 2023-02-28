%精确画出箭头
%用plot函数画直线, 用fill函数画三角形
%Pstart=[x0,y0]起始坐标; Pend=[x1,y1]终止坐标
%以下自变量可以省略, 采用默认值
%LineWidth线条粗细; Ltriangle三角形长度; Htriangle三角形宽度
%三角形的三个点中, P(1)是箭头的尖尖, P(2)和P(3)按照逆时针排序

%先用setfigure('blank')生成空白的画图板

function info=FineArrow(Pstart,Pend,LineWidth,Ltriangle,Htriangle)

L=vmag(Pend-Pstart); %箭头长度
if nargin==2 %默认形状
    LineWidth=L*0.005;
    Ltriangle=L*0.04;
    Htriangle=L*0.02;
end

%三角形的各个顶点
P(3,:)=[Pend(1)-Ltriangle,-Htriangle/2];
P(1,:)=Pend; P(2,:)=[Pend(1)-Ltriangle,Htriangle/2];

%绕原点旋转三角形
theta=atan2(Pend(2)-Pstart(2),Pend(1)-Pstart(1));
[P(:,1),P(:,2)]=turn2(P(:,1),P(:,2),theta);

%平移三角型
P(:,1)=P(:,1)+Pstart(1); P(:,2)=P(:,2)+Pstart(2);

%画箭头
temp=(L-Ltriangle)/L;
LineEnd=Pstart*(1-temp)+Pend*temp;
Plot([Pstart; LineEnd],'Color','k','LineWidth',LineWidth);
Fill(P,'k','EdgeColor','none');

%输出箭头形状配置
info=num2cell([LineWidth,Ltriangle,Htriangle]);
end