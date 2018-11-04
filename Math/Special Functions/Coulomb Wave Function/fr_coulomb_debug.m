% coulombWave debug

l = 0:40;
m = 0;
rmax = 50; Nr = 300;
r = linspace(1e-3,rmax,Nr);
k = 1;
k_th = 0; k_ph = 0;
fr = fr_coulomb(l,m,r,k,k_th,k_ph);

th = linspace(0,2*pi,400);
[f, R, Th, Ph] = fr_eval(fr,l,m,r,th,0);
figure; surfSph(R,Th,Ph,abs(f));
xlabel x; ylabel y; zlabel z;
view(0,0);

figure; surfSph(R,Th,Ph,angle(f));
xlabel x; ylabel y; zlabel z;
view(0,0);
