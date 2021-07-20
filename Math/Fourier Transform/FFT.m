% fft approximation of the analytical fourier transform from f(x) to g(k)
% x and k are both equally spaced, x starts from x0 equally spaced by dx
% norm(g) = norm(f)
% numel(g) = interpN * numel(f)

function [g, k] = FFT(f, x0, dx, dim, interpN)
if exist('interpN', 'var')
    f = fftresize(f, interpN);
end
if exist('dim', 'var')
    g = sffts(f, dim)*(dx/sqrt(2*pi));
else
    g = sffts(f)*(dx/sqrt(2*pi));
end

if nargin < 3
    if isvector(f)
        k = fftlinspace(2*pi/dx, numel(f));
    else
        k = fftlinspace(2*pi/dx, size(f,1));
    end
else
    k = fftlinspace(2*pi/dx, size(f,dim));
end
x_mid = (2*x0 + (numel(f)-1)*dx)/2; % mid point of x grid
if (x_mid ~= 0)
    if (isvector(g))
        g = g .* exp(-1i*k*x_mid);
    else
        error('asymmetric x not implemented!');
    end
end
end
