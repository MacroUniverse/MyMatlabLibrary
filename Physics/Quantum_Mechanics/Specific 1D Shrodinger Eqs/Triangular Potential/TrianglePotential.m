%Triangle Potential
close all;

% airy function
Ai=@(x) airy(x);
Bi=@(x) airy(2,x);

% derivative
h=1e-6;
Ai1=@(x) (airy(x+h)-airy(x-h))/(2*h); %Ai'
Bi1=@(x) (airy(2,x+h)-airy(2,x-h))/(2*h); %Bi'


% % Plot
% figure; hold on; grid on
% plot(x,Ai(x)); plot(x,Ai1(x));
% figure; hold on; grid on
% plot(x,Bi(x)); plot(x,Bi1(x));

% determinant as a function of Energy
E=linspace(-0.99,-0.01,1000); %E has the unit of V0  (-1<E<0)
y1=zeros(size(E)); y2=y1;
for ii=1:numel(E)
    y1(ii)=DetOdd(E(ii),Ai,Bi,Ai1,Bi1);
    y2(ii)=DetEven(E(ii),Ai,Bi,Ai1,Bi1);
end

figure; hold on; grid on
plot(E,y1,'b'); plot(E,y2,'r');
axis([-1,0,-0.02,0.02]);

E0(1)=fzero(@(x) DetEven(x,Ai,Bi,Ai1,Bi1),-0.85);
E0(2)=fzero(@(x) DetOdd(x,Ai,Bi,Ai1,Bi1),-0.6);
E0(3)=fzero(@(x) DetEven(x,Ai,Bi,Ai1,Bi1),-0.45);
E0(4)=fzero(@(x) DetOdd(x,Ai,Bi,Ai1,Bi1),-0.3);
E0(5)=fzero(@(x) DetEven(x,Ai,Bi,Ai1,Bi1),-0.15);
E0(6)=fzero(@(x) DetOdd(x,Ai,Bi,Ai1,Bi1),-0.05);
disp('all energy levels for bound states')
disp(E0);

PlotWaveFun


%Continuous Wave Fun
E=1;
t1=(20*pi^2)^(1/3);
t2=sqrt(20*pi^2*E);

matC=[Ai(-2*t1), Bi(-2*t1); 
      Ai1(-2*t1), Bi1(-2*t1)];
C=matC\[1;0];
C1=C(1); C2=C(2);

matD=[cos(t2), sin(t2);-t2*sin(t2), t2*cos(t2)];
bD=[C1*Ai(-t1)+C2*Bi(-t1); C1*t1*Ai(-t1)+C2*t1*Bi(-t1)];
D=matD\bD;
D1=D(1); D2=D(2);
A=sqrt(D1^2+D2^2)*sqrt(pi/2);
C1=C1/A; C2=C2/A; D1=D1/A; D2=D2/A;


Nplot=300;
x=linspace(0,3,Nplot);
y=zeros(size(x));
for ii=1:Nplot
    if x(ii)<1
        y(ii)=C1*Ai(t1*x(ii)-2*t1)+C2*Bi(t1*x(ii)-2*t1);
    else
        y(ii)=D1*cos(t2*x(ii))+D2*sin(t2*x(ii));
    end
end

figure; hold on; grid on
plot(x,y);





