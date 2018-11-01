% fft_sph debug

%% 3D gaussian

% create 3D gaussian wave
close all;
rmax = 6; Nr = 400; % radial grid
l = 0:14; m = -14:14; % as in Y_lm
sigma = 1; % gaussian standard deviation
k0 = 2; th = pi/2; ph = pi/9; % central momentum
scaled = true; % use scaled "fr"

r = linspace(0.001,rmax,Nr);
fr = fr_plane_wave(r,l,m,k0,th,ph,scaled);

gauss = exp(-(r/(2*sigma)).^2)/(2*pi*sigma^2)^0.75;
fr = fr_mul(fr, gauss);

th1 = linspace(0,2*pi,200); ph1 = th1;
[f, R, Th, Ph] = fr_eval(fr, l, m, r, th1, ph, scaled);

figure(1); title('|\Psi|'); hold on;
surfSph(R,Th,Ph,abs(f));
shading interp; axis equal; view(51,19);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);

figure(2); title('arg(\Psi)'); hold on;
surfSph(R,Th,Ph,angle(f));
shading interp; axis equal; view(51,19);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);

[f, R, Th, Ph] = fr_eval(fr, l, m, r, pi/2, ph1, scaled);
figure(1); surfSph(R,Th,Ph,abs(f)); shading interp;
figure(2); surfSph(R,Th,Ph,angle(f)); shading interp;

% wave function norm
disp('norm2 = '); disp(fr_norm2(fr,r));

% numerical spectrum
k = linspace(k0-3,k0+3,50);
spec = fr_fft(r, fr, l, m, k, th, ph, scaled);
figure; plot(k, abs(spec)); title('momentum spectrum');

% analytical spectrum
sigmap = 0.5/sigma;
g = exp(-(k-k0).^2/(2*sigmap)^2)/(2*pi*sigmap^2)^0.75;
hold on; plot(k,g,'.');

%% hydrogen ground state

rmax = 10;
r = linspace(0.096,rmax,1000);
fr = cell(1,1);
fr{1,1} = 2*exp(-r).*r.^scaled;
l = 0; m = 0;
[f, R, Th, Ph] = fr_eval(fr, l, m, r, pi/2, ph1, scaled);
surfSph(R,Th,Ph,abs(f));
shading interp; axis equal; view(0,90);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);
k = linspace(-4, 4, 200);

g = fr_fft(r,fr,l,m,k,0,0,scaled);
figure; plot(k,abs(g),'.'); hold on;

% analytical spectrum
g1 = 2*sqrt(2)./(pi*(k.^2+1).^2);
plot(k, g1);
