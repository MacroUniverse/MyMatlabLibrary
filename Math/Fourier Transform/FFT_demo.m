% FFT test
% turns out FFT and DFT only has 1e-13 maximum error in this case!

close all;
x0 = 0;
f = @(x) exp(10i*(x-x0)).*exp(-(x-x0).^2);
xspan = [-40 ,40]; Nx = 1000000;
x = linspace(xspan(1),xspan(2),Nx);
figure; plot(x,[real(f(x));imag(f(x))]); axis([xspan/6,-1,1]);
title('Original Function'); xlabel('x'); ylabel('y');
kspan = [-16,16]; 

% continuous FFT
% agrees with analytical solution
Nk = 500;
[k,g1,g1h] = CFT(f,xspan,kspan,Nk);
figure; plot(k,[real(g1); imag(g1)]); 
title('the Continuout FT spectrum'); xlabel('\omega'); ylabel('g');
axis([kspan(1),kspan(2),0,1]);

% DFT method (is exactly the same as FFT)
% Nx = 200; 
% Nk = round(Nx/2); k = 2*pi*(0:Nk-1)/(x2-x1);
% x = linspace(x1,x2,Nx);
% g2 = dft(f(x));  g2 = g2(1:Nk);
% figure; plot(k,abs(g2)); title('the DFT method')

% FFT method
[k,g3] = FFT(x,f(x));
figure; plot(k,[real(g3); imag(g3)]); 
title('FFT spectrum'); xlabel('\omega'); ylabel('g');
axis([kspan(1),kspan(2),0,1]);


% inverse FFT
% iFFT of FFT is not a good idea
% but ifft of fft is very exact!
% because idft matrix is just the transpose of dft matrix, which is
% hermitian. So it's the exact inverse matrix.

[x1,y1] = iFFT(k,g3);
figure; plot(x1,[real(y1); imag(y1)]); 
title('iFFT to get back'); xlabel('x'); ylabel('y');
axis([xspan/6,-1,1])

