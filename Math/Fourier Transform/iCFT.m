% Continuous Fourier Transform by Integration
% g must be a function handle
% fh is function handle, f = fh(linspace(xmin,xmax,Nx))
% input the 7th argument to plot spectrum

function [x,f,fh] = iCFT(g,kspan,xspan,Nx,~)
x = linspace(xspan(1),xspan(2),Nx);
f = zeros(1,Nx);
for ii = 1:Nx
    integrand = @(k)  g(k).*exp(1i*k*x(ii));
    f(ii) = integral(integrand,kspan(1),kspan(2), 'AbsTol',1e-8);
end
f = f/sqrt(2*pi);

if nargin == 5
    figure; plot(x,f);
end

if nargout == 3
    fh = @(xq) interp1(x,f,xq,'spline');
end

end