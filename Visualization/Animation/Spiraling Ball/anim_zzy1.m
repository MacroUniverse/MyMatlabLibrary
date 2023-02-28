function f=anim_zzy1(K,ki)
t1=(0:1000)/1000*10*pi;x1=cos(t1);y1=sin(t1);z1=-t1;
t2=(0:10)/10;x2=x1(end)*(1-t2);y2=y1(end)*(1-t2);z2=z1(end)*ones(size(x2));
t3=t2;z3=(1-t3)*z1(end);x3=zeros(size(z3));y3=x3;
t4=t2;x4=t4;y4=zeros(size(x4));z4=y4;
x=[x1 x2 x3 x4];y=[y1 y2 y3 y4];z=[z1 z2 z3 z4];
plot3(x,y,z,'b'),axis off

h=line('color',[1 0 0],'Marker','.','MarkerSize',40,'EraseMode','xor');

n=length(x);i=1;j=1;
while 1 
    set(h,'xdata',x(i),'ydata',y(i),'zdata',z(i));
    drawnow;
    pause(0.0005)
    i=i+1;
    if nargin==2&nargout==1
        if(i==ki&j==1);f=getframe(gcf);end
    end
    if i>n
        i=1;j=j+1;
        if j>K;break;end
    end
end