% Fourier series by FFT
function [C, k] = FS(f, x0, dx)
[g, k] = FFT(f, x0, dx, Nk, dim);
C = sqrt(2*pi)/(N*dx) * g;
end
