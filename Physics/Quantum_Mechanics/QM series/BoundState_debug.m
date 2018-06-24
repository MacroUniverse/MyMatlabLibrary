%bound_debug
close all;

%Square Well

V0=100;
f1=@(x,E) cos(sqrt(2*(E+V0))*x);
f2=@(x,E) sin(sqrt(2*(E+V0))*x);
g=@(x,E) exp(-sqrt(-2*E)*x);
[E,C]=bound(f1,f2,1,g,[-V0,0],100); %如果基态不是一个包, 增加最后一个参数试试.

%Triangular Well
V0=20;
f1=@(x,E) airy(V0^1/3*(x-1-E/V0));
f2=@(x,E) airy(2,V0^1/3*(x-1-E/V0));
f3=@(x,E) exp(-sqrt(-E)*x);
[E,C]=bound(f1,f2,1,g,[-V0,0],100)