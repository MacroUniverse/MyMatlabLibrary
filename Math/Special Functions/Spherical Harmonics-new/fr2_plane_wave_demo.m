% debug plane wave
close all;
rmax = 2*pi;
lmax = 20;
k = 1; th = pi/2; ph = pi/9;
scaled = false;

r = linspace(0.01,rmax,1000);
Npw = (lmax+1)^2; l = zeros(1, Npw); m = zeros(1, Npw);
pw = 1;
for l1 = 0:lmax
    for m1 = -l1:l1
        l(pw) = l1; m(pw) = m1;
        pw = pw + 1;
    end
end

data = fr2_plane_wave(r,l,m,k,th,ph,scaled);

th1 = linspace(-pi,pi,200);
[f, R, Th, Ph] = fr2_eval(data, l, m, r, th1, ph, scaled);
figure(1); grid on; hold on;
surfSph(R,Th,Ph,real(f));
view(63,35);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);
figure(2); grid on; hold on;
surfSph(R,Th,Ph,imag(f));
view(63,35);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);

ph1 = linspace(0,2*pi,200);
[f, R, Th, Ph] = fr2_eval(data, l, m, r, th, ph1, scaled);
figure(1); surfSph(R,Th,Ph,real(f));
view(63,35);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);
figure(2); surfSph(R,Th,Ph,imag(f));
view(63,35);
xlabel x; ylabel y; zlabel z;
axis([-rmax,rmax,-rmax,rmax]);
