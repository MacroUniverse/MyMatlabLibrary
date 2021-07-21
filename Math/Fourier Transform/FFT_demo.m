% see FTExp_ex2
clear;
a = 1/4; k0 = 4;
x_shift = pi/(2*a);
Nx = 5000;
x = linspace(-pi/(2*a), pi/(2*a), Nx) + x_shift;
dx = (x(end)-x(1))/(Nx-1);
f = exp(1i*k0*(x-x_shift)).*cos(a*(x-x_shift)).^2;
figure; plot(x, real(f), '.-'); hold on;
plot(x, imag(f), '.-');

% FFT
[g1, k1] = FFT(f, x(1), dx);
% FFT interp
[g2, k2] = FFT(f, x(1), dx, Nx*10);
% analytical
k = k2;
g = sqrt(2*pi)*a./(4*a^2-(k-k0).^2).*sinc((pi*(k-k0))/(2*a));
g = g .* exp(-1i*k*x_shift);

figure;
plot(k, g, '.-'); hold on;
plot(k1, g1, 'o');
axis([1, 7, -1.5, 2.5]);
plot(k2, g2, '.');
legend('analytical', 'FFT', 'FFT interp');
