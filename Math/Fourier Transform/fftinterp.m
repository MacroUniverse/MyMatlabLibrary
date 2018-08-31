function [f1, x1] = fftinterp(f, N1, dx)
N = numel(f);
f1 = siffts(fftresize(sffts(f), N1))*N1/N;
if nargout == 2
    x1 = fftlinspace(dx*N, N1);
end
end