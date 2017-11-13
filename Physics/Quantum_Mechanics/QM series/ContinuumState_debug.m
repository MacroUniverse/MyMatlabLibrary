%continuum_debug
E=0.2;
Odd_Even='odd';

t1=(20*pi^2)^(1/3);
t2=sqrt(20*pi^2*E);

f1=@(x) airy(t1*x-2*t1);
f2=@(x) airy(2,t1*x-2*t1);
g1=@(x) cos(t2*x);
g2=@(x) sin(t2*x);

C=continuum(f1,f2,1,g1,g2,Odd_Even);
F1=@(x) C(1)*f1(x)+C(2)*f2(x);
F2=@(x) C(3)*g1(x)+C(4)*g2(x);
plotPW(500,{F1,F2},[0 1 4],Odd_Even,'r')