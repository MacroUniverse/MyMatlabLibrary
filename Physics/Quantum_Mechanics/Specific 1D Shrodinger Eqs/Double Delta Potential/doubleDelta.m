close all;
Nplot=300;
A=linspace(0,3,Nplot);
x=zeros(size(A));
for ii=1:Nplot
    f=@(x) exp(-2*x*A(ii))-(x-1);
    x(ii)=fzero(f,[0.0001,3]);
end
E=-x.^2/2; 
figure; hold on; grid on
plot(A,E);
xlabel('a (in unit of 1/(m V0 a0) )')
ylabel('Energy (in unit of m*a0^2*V0^2)')