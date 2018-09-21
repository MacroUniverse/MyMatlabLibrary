% sample a numerical function f(x) in every "step" points
function [f1, x1, N1] = fftsample(f, step, x)
N = numel(f);
iseven = mod(N,2) == 0;
if iseven
    mid = N/2+1;
else
    mid = (N+1)/2;
end
Nstep1 = floor((mid-1)/step);
Nstep2 = floor((N-mid)/step);
if iseven && Nstep2 == Nstep1
    Nstep2 = Nstep2 - 1;
end
ind1 = mid - Nstep1*step;
ind2 = mid + Nstep2*step;
f1 = f(ind1:step:ind2);
if nargout >= 2
    x1 = x(ind1:step:ind2);
end
N1 = size(f1);
end
