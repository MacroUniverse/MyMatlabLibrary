%有限深势阱的数值解

close all;
V=15*pi^2;
x=linspace(-V,0,2000);

%偶函数的情况
y1=sqrt(2*(x+V)).*tan(1/2*sqrt(2*(x+V)));
y2=sqrt(-2*x);
plot(x,y1);
hold on
plot(x,y2);

%奇函数的情况
figure
y1=sqrt(2*(x+V)).*cot(1/2*sqrt(2*(x+V)));
y2=-sqrt(-2*x);
plot(x,y1);
hold on
plot(x,y2);