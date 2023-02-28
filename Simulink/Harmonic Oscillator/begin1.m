function  begin1
% 执行之前，先执行 two_jian3xie2zhen4zi3_accel_rtw.mdl
% 然后将以下命令粘贴在command window中
clc;clf;
x=xyt(:,1);y=xyt(:,2);t=xyt(:,3);
dt=[diff(t)
         0];
z=zeros(size(x));
axis([-5 5 -5 5 -5 5]);grid;
h=small_ball(30);
h1=small_ball(30);
for i=1:length(x)
update_move(h,x(i),0,0,0)
update_move(h1,y(i),0,0,dt(i))
end