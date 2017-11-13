% fft approximation of the analytical fourier transform
% y(x) is the original function
% g(k) is the angular frequency spectrum

function [k,g] = FFT(x,y,kspan)

Nx = numel(x); xmin = x(1); xmax = x(Nx);
dx = (xmax-xmin)/(Nx-1);
Nk = floor(Nx/2);
dk = 2*pi/(xmax-xmin);
k = (-Nx+Nk : Nk-1)*dk;
g = fft(y); g = [g(Nk+1:Nx) g(1:Nk)]*dx/sqrt(2*pi);

if nargin == 3
    mark = (k>=kspan(1) & k<=kspan(2)) ;
    k = k(mark);
    g = g(mark);
elseif nargin < 2
    error('must input x and y at least');
end

g = g.*exp(-1i*k*xmin);

end