% cn1D test
function cn1D_test
close all;
Nplot = 7;
xspan = [-2, 5]; Nx = 1001;
tspan = [0, 0.2]; Nt = 1001;%ceil((tspan(2)-tspan(1))/0.005);
x = linspace(xspan(1),xspan(2),Nx);
psi0 = exp(-2*x.^2).*exp(1i*15*x);
%psi0 = sin(x);
figure; plot(x, abs(psi0).^2); hold on;
Psi = cn1D(@V, xspan, tspan, psi0, Nx, Nt);
for ii = 1:Nplot
    plot(x, abs(Psi(:,round(Nt*ii/Nplot))).^2);
end
end

function out = V(x, ~)
out = 0;
end