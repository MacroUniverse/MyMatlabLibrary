% cn1D_IT test

function cn1D_IT_test
close all;
Nplot = 15;
xspan = [0, pi]; Nx = 1000;
tspan = [0, 8]; Nt = ceil((tspan(2)-tspan(1))/0.005);
x = linspace(xspan(1),xspan(2),Nx);
dx = diff(xspan)/Nx;
psi0 = exp(-2*(x - pi/3).^2);
%psi0 = exp(-2*x.^2).*exp(1i*15*x);
%psi0 = sin(x);
psi0 = psi0/sqrt(psi0*psi0'*dx);
figure; plot(x, abs(psi0).^2); hold on;
Psi = cn1D_IT(@V, xspan, tspan, psi0, Nx, Nt);
for ii = 1:Nplot
    plot(x, abs(Psi(:,round(Nt*ii/Nplot))).^2);
end

% analytical solution
y = sin(x);
y = y/sqrt(y*y'*dx);
plot(x, abs(y).^2, '.');
end

function out = V(~, ~)
out = 0;
end