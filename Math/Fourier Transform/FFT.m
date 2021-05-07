% fft approximation of the analytical fourier transform
% norm(g) = norm(f)
% numel(g) = interpN * numel(f)

function [g, k] = FFT(f, dx, dim, interpN)
if exist('interpN', 'var')
    f = fftresize(f, interpN);
end
if exist('dim', 'var')
    g = sffts(f, dim)*(dx/sqrt(2*pi));
else
    g = sffts(f)*(dx/sqrt(2*pi));
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
