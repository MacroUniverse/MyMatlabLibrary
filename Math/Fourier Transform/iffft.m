% inverse free fast fourier transform
% equivalent to f(j) = sum(g.*exp(1i*k_j*k))/N;
% k and x must be linspaced and increasing
% Nx is optional, Nx > numel(k)
function [f, x] = iffft(g, k, x0, Nx)
    Nk = numel(k); dk = (k(end)-k(1))/(Nk-1);
    if nargin < 4, Nx = Nk;
    elseif (Nx < Nk), error('Nx < Nk not allowed!');
    end
    if x0 == 0
        f = siffts(fftresize(g, Nx));
    else
        f = siffts(fftresize(g.*exp((1i*x0)*k), Nx));
    end
    if mod(Nk, 2) == 0
        k0 = k(0.5*Nk+1);
    else
        k0 = k(0.5*(Nk+1));
    end
    if k0 ~= 0
        x = fftlinspace(2*pi/dk, Nx, x0);
        f = f.*exp((1i*k0)*(x-x0));
    elseif nargout == 2
        x = fftlinspace(2*pi/dk, Nx, x0);
    end
end
