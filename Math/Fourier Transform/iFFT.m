% fft approximation of the analytical inverse fourier transform
% g(k) is the angular frequency spectrum
% y(x) is the original function

function [x,y] = iFFT(k,g,xspan)

Nk = numel(k); kmin = k(1); kmax = k(Nk);
dk = (kmax-kmin)/(Nk-1);
Nx = floor(Nk/2);
dx = 2*pi/(kmax-kmin);
x = (-Nk+Nx:Nx-1)*dx;
y = ifft(g); y = [y(Nx+1:Nk), y(1:Nx)]*dk/sqrt(2*pi);
y = y*Nk; % ifft scales down y by Nk!

if nargin == 3
    mark = (x>=xspan(1) & x<=xspan(2)) ;
    x = x(mark);
    y = y(mark);
elseif nargin < 2
    error('must input k and g at least');
end

y = y.*exp(1i*kmin*x);

end