function y = siffts(x)
    y = fftshift(ifft(ifftshift(x)));
end
