% coulombWave debug

l = 0:40;
m = 0;
rmax = 50; Nr = 300;
r = linspace(1e-3,rmax,Nr);
k = 1;
k_th = 0; k_ph = 0;
fr1 = fr_coulomb(l,m,r,k,k_th,k_ph,-1);

th = linspace(0,2*pi,400);
[f1, R, Th, Ph] = fr_eval(fr1,l,m,r,th,0);
figure; surfSph(R,Th,Ph,abs(f1));
xlabel x; ylabel y; zlabel z;
view(0,0);

figure; surfSph(R,Th,Ph,angle(f1));
xlabel x; ylabel y; zlabel z;
view(0,0);
