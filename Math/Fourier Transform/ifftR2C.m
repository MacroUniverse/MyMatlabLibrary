% real function to complex function with negative fft spectrum only
% real(g) = f (approx)
% Nresize is optional, use a large number of make g more accurate
function g = ifftR2C(f, Nresize)
if nargin >= 2
    N0 = numel(f);
    N = Nresize;
    f = fftresize(f, Nresize);
else
    N = numel(f);
end
g = siffts(f);
if mod(N,2) == 0
    mid = N/2+1;
else
    mid = (N+1)/2;
end
g(1:mid-1) = 0;
g(mid) = g(mid)/2;
g = sffts(g)*2;
if nargin >= 2
    g = fftresize(g, N0);
end
end
