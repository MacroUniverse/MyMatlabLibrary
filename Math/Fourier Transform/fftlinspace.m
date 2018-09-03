% generate N grid points from bandwidth
% input 2 or 3 arguments
function x = fftlinspace(L, N, x0)
if mod(N, 2) == 0
    Lh = 0.5*L; dx = L/N;
    if nargin == 3
        x = linspace(-Lh+x0, Lh-dx+x0, N);
    else
        x = linspace(-Lh, Lh-dx, N);
    end
else
    a = (N-1)*L/(2*N);
    if nargin == 3
        x = linspace(-a+x0, a+x0, N);
    else
        x = linspace(-a, a, N);
    end
end
end
