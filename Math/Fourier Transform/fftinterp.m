% approximate sinc interpolation by fft
% N is optional, used to zero-pad f
function [f1, x1] = fftinterp(f, N1, dx, N)
if ~exist('N','var') || isempty(N)
    N = numel(f);
else
    f = fftresize(f, N);
end
f1 = siffts(fftresize(sffts(f), N1))*N1/N;
if nargout == 2
    x1 = fftlinspace(dx*N, N1);
end
end