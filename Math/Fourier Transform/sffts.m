function y = sffts(x)
    y = fftshift(fft(ifftshift(x)));
end
