% numeric fourier transform
% specified spectrum range

function g = FT(f, xmin, xmax, k)
Nx = numel(f); Nk = numel(k);
dx = (xmax - xmin)/Nx;
g = zeros(1, Nk);
for ii = 1:Nk
    dexpo = exp(-1i*k(ii)*dx);
    expo = exp(-1i*k(ii)*xmin)/dexpo;
    for jj = 1:Nx
        expo = expo * dexpo;
        g(ii) = g(ii) + f(jj)*expo;
    end
end
g = g*dx/sqrt(2*pi);
end
