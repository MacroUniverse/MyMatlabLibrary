% shifted fft
function y = sffts(x, dim)
    if nargin < 2
        y = fftshift(fft(ifftshift(x)));
    else
        y = fftshift(fft(ifftshift(x, dim),[], dim), dim);
    end
end
