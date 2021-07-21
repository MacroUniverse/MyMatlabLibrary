% see FTExp_ex2
clear; close all;
a = 1/4; k0 = 6;
x_shift = 10;
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
plot(k, real(g), '.-'); hold on;
plot(k1, real(g1), 'o');
plot(k2, real(g2), '.');
axis([k0-3, k0+3, -2.7, 2.7]);
legend('analytical', 'FFT', 'FFT interp');

disp(['norm2(f) = ' num2str(sum(abs(f).^2)*dx, 14)]);
disp(['norm2(g) = ' num2str(sum(abs(g).^2)*(k(2)-k(1)), 14)]);
disp(['norm2(g1) = ' num2str(sum(abs(g1).^2)*(k1(2)-k1(1)), 14)]);
