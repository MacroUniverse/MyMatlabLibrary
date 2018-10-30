% debug plane wave
close all;
rmax = 2*pi;
r = linspace(0.01,rmax,1000);
l = 0:20; m = -20:20;
k = 1; th = pi/2; ph = pi/2;
f_R = plane_wave_sph(r,l,m,k,th,ph);


th1 = linspace(-pi,pi,200);
[f, R, Th, Ph] = f_SphHarm(f_R, l, m, r, th1, ph);
figure(1); hold on;
surfSph(R,Th,Ph,real(f));
shading interp; axis equal; view(90,90);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);
figure(2); hold on;
surfSph(R,Th,Ph,imag(f));
shading interp; axis equal; view(90,90);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);


ph1 = linspace(0,2*pi,200);
[f, R, Th, Ph] = f_SphHarm(f_R, l, m, r, th, ph1);
figure(1); surfSph(R,Th,Ph,real(f));
shading interp; axis equal; view(90,90);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);
figure(2); surfSph(R,Th,Ph,imag(f));
shading interp; axis equal; view(90,90);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);

