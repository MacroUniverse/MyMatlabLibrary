%实验数据纸

%2012/11/12更新:aspect调整, 调整axis的DataAspectRatio性质, 使格子变为方形
%有待完善的地方: 完全用自己画格子, 自己标数据(可以控制有效位数)

Domain=[0 5        50 100];
Dx=0.5;Dy=5; %1大格(10小格)的数

XTick=Domain(1):Dx:Domain(2);xTick=Domain(1):Dx/10:Domain(2);
YTick=Domain(3):Dy:Domain(4);yTick=Domain(3):Dy/10:Domain(4);
figure;
axis(Domain);
ha=gca;
set(ha,'XTick',XTick, 'YTick',YTick);
set(gcf,'Color',[1 1 1]);

%画网
[X,Y]=meshgrid(XTick,YTick);
[x,y]=meshgrid(xTick,yTick);
plotnet(x,y,'Color',[0.8 0.4 0.4]);
plotnet(X,Y,'Color',[0.8 0.3 0.3],'LineWidth',1.5);%粗格子
axis square;
xlabel('冷却时间t,单位:min');
ylabel('温度T,单位:摄氏度');
title('T-t图');

%画数据
xData=[0 0.5 1 1.5 2 2.5 3.17 3.5 4 4.5 5];
yData=[100 94 88.5 83.5 78.5 74.5 69 66.5 63.5 60.5 57.5];
plot(xData,yData,'Color','k','LineStyle','none','Marker','+','MarkerSize',6);
set(gca,'DataAspectRatio',[Dx,Dy,1]);



