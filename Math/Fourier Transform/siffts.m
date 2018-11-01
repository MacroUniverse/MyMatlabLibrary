% shifted ifft
function y = siffts(x, dim)
    if nargin < 2
        y = fftshift(ifft(ifftshift(x)));
    else
        y = fftshift(ifft(ifftshift(x, dim),[], dim), dim);
    end
end
