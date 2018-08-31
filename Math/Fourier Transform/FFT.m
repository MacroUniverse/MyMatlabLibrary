% fft approximation of the analytical fourier transform
% norm(g) = norm(f)

function g = FFT(f, dx)
g = sffts(f)*(dx/sqrt(2*pi));
end
