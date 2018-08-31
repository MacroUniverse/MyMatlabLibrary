% fft approximation of the analytical inverse fourier transform
% norm(f) = norm(g)
function f = iFFT(g, dk)
f = siffts(g)*(numel(g)*dk/sqrt(2*pi));
end
