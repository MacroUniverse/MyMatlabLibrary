% fft approximation of the analytical fourier transform
% norm(g) = norm(f)

function [g, k] = FFT(f, dx, dim)
if nargin < 3
    g = sffts(f)*(dx/sqrt(2*pi));
else
    g = sffts(f, dim)*(dx/sqrt(2*pi));
end

if nargout == 2
    if nargin < 3
        if isvector(f)
            k = fftlinspace(2*pi/dx, numel(f));
        else
            k = fftlinspace(2*pi/dx, size(f,1));
        end
    else
        k = fftlinspace(2*pi/dx, size(f,dim));
    end
end
end
