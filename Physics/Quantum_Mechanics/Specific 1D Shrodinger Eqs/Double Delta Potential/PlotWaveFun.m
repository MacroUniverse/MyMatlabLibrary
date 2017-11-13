Nplot=400;
A=15;
f=@(x) exp(-2*x*A)-(x-1);
X=fzero(f,[1e-4,5]);
E=-X^2/2;

x=linspace(0,40,Nplot);
y=zeros(size(x));
b=1-1/X;

for ii=1:Nplot
    if x(ii)< A
        y(ii)=2*b*cosh(X*x(ii));
    else
        y(ii)=exp(-X*x(ii));
    end
end

figure; hold on; grid on
plot(x,y,'r');
plot(-x,y,'r');
plot([-A,-A],[0,max(y)],'b'); plot([A,A],[0,max(y)],'b');
xlabel('x in unit of 1/(2 m a0 V0)')
ylabel('unnormalized wave function')