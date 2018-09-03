% fft approximation of the analytical inverse fourier transform
% norm(f) = norm(g)
function [f, x] = iFFT(g, dk)
f = siffts(g)*(numel(g)*dk/sqrt(2*pi));
if nargout == 2
    x = fftlinspace(2*pi/dk, numel(f));
end
end
