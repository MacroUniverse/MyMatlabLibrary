% fft approximation of the analytical fourier transform from f(x) to g(k)
% x and k are both equally spaced, x starts from x0 equally spaced by dx
% norm(g) = norm(f)
% numel(g) = Nk

function [g, k] = FFT(f, x0, dx, Nk, dim)
x_mid = (2*x0 + (numel(f)-1)*dx)/2; % mid point of x grid
if exist('Nk', 'var')
    f = fftresize(f, Nk);
end
if exist('dim', 'var')
    g = sffts(f, dim)*(dx/sqrt(2*pi));
else
    g = sffts(f)*(dx/sqrt(2*pi));
end

if ~exist('dim', 'var')
    if isvector(f)
        k = fftlinspace(2*pi/dx, numel(f));
    else
        k = fftlinspace(2*pi/dx, size(f,1));
    end
else
    k = fftlinspace(2*pi/dx, size(f,dim));
end

if (abs(x_mid/x0) > 1e-14)
    if (isvector(g))
        k = reshape(k, size(g));
        g = g .* exp(-1i*k*x_mid);
    else
        error('asymmetric x not implemented!');
    end
end
end
