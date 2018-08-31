% generate N grid points from bandwidth
function x = fftlinspace(L, N)
if mod(N, 2) == 0
    Lh = 0.5*L; dx = L/N;
    x = linspace(-Lh, Lh-dx, N);
else
    a = (N-1)*L/(2*N);
    x = linspace(-a, a, N);
end
end
