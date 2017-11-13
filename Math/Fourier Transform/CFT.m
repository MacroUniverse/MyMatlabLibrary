% Continuous Fourier Transform by Integration
% f must be a function handle
% gh is function handle, g = gh(linspace(kmin,kmax,Nk))
% input the 7th argument to plot spectrum

function [k,g,gh] = CFT(f,xspan,kspan,Nk,~)
k = linspace(kspan(1),kspan(2),Nk);
g = zeros(1,Nk);
for ii = 1:Nk
    integrand = @(x)  f(x).*exp(-1i*k(ii)*x);
    g(ii) = integral(integrand,xspan(1),xspan(2), 'AbsTol',1e-8);
end
g = g/sqrt(2*pi);

if nargin == 5
    figure; plot(k,g);
end

if nargout == 3
    gh = @(kq) interp1(k,g,kq,'spline');
end

end