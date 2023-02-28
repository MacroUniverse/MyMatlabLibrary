function  begin1
clc
x=xyt(:,1);y=xyt(:,2);t=xyt(:,3);
dt=[diff(t)
         0];
z=zeros(size(x));
axis([-5 5 -5 5 -5 5])
h=small_ball(30);
h1=small_ball(30);
for i=1:100
update_move(h,x(i),0,0,0)
update_move(h1,y(i),0,0,dt(i))
end