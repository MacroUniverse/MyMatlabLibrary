% fft approximation of the analytical fourier transform
% norm(g) = norm(f)

function [g, k] = FFT(f, dx)
g = sffts(f)*(dx/sqrt(2*pi));
if nargout == 2
    k = fftlinspace(2*pi/dx, numel(f));
end
end
