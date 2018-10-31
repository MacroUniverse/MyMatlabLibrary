% debug plane wave
close all;
rmax = 2*pi;
r = linspace(0.01,rmax,1000);
l = 0:20; m = -20:20;
k = 1; th = pi/2; ph = pi/9;
fr = fr_plane_wave(r,l,m,k,th,ph);


th1 = linspace(-pi,pi,200);
[f, R, Th, Ph] = fr_eval(fr, l, m, r, th1, ph);
figure(1); grid on; hold on;
surfSph(R,Th,Ph,real(f));
shading interp; axis equal; view(63,35);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);
figure(2); grid on; hold on;
surfSph(R,Th,Ph,imag(f));
shading interp; axis equal; view(63,35);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);


ph1 = linspace(0,2*pi,200);
[f, R, Th, Ph] = fr_eval(fr, l, m, r, th, ph1);
figure(1); surfSph(R,Th,Ph,real(f));
shading interp; axis equal; view(63,35);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);
figure(2); surfSph(R,Th,Ph,imag(f));
shading interp; axis equal; view(63,35);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);

