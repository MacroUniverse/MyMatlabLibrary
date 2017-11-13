% discrete fourier series using DFT
% x must be equally spaced
% equivalent to numerical following integral
% g(N) = 1/L* int f(x)*exp(1i*N*pi*x/(L/2) dx
% k = 2*pi/L*N

function [g,N,k] = DFS(x,y,kspan) % can change kspan to Nspan
Nx = numel(x);
dx = x(2)-x(1);
L = x(end)-x(1);
g = fft(y)/L*dx;

% rearrange to put N=0 in the middle
mid = ceil(Nx/2);
g = [g(mid+1:Nx),g(1:mid)];
N = mid-Nx:mid-1;
k = 2*pi/L*N;

% mark = N<=Nspan(2) & N>=Nspan(1);
mark = k<=kspan(2) & k>=kspan(1);

g = g(mark); N = N(mark); k = k(mark);
end