% free fast fourier transform
% equivalent to g(j) = sum(f.*exp(-1i*k_j*f));
% x and k must be linspaced and increasing
% Nk is optional, Nk > numel(x)
function [g, k] = ffft(f, x, k0, Nk)
    Nx = numel(x); dx = (x(end)-x(1))/(Nx-1);
    if nargin < 4, Nk = Nx;
    elseif (Nk < Nx), error('Nk < Nx not allowed!');
    end
    if mod(Nx, 2) == 0
        x0 = x(0.5*Nx+1);
    else
        x0 = x(0.5*(Nx+1));
    end
    if k0 == 0
        g = sffts(fftresize(f, Nk));
    else
        g = sffts(fftresize(f.*exp((-1i*k0)*(x-x0)), Nk));
    end
    if x0 ~= 0
        k = fftlinspace(2*pi/dx, Nk, k0);
        g = g.*exp((-1i*x0)*k);
    elseif nargout == 2
        k = fftlinspace(2*pi/dx, Nk, k0);
    end
end
