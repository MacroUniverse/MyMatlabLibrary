% demonstration of fr_coulomb() function
close all;


%% spherical coordinates
scaled = false;
l = 0:30;
m = -30:30;
ZZ = -1;
rmax = 10; Nr = 100;
Sign = -1;
r = linspace(0,rmax,Nr);
k = 1;
k_th = pi/4; k_ph = 0;
fr1 = fr_coulomb(l,m,r,k,k_th,k_ph,ZZ,Sign,scaled);

th = linspace(0,2*pi,400);
[f1, R, Th, Ph] = fr_eval(fr1,l,m,r,th,scaled);
figure; surfSph(R,Th,Ph,abs(f1));
view(0,0); caxis([0,0.16]);

figure; surfSph(R,Th,Ph,angle(f1));
xlabel x; ylabel y; zlabel z;
view(0,0);


%% cartesian coordinates
xmin = -rmax; xmax = rmax; Nx = 100;
zmin = -rmax; zmax = rmax; Nz = 100;
x = linspace(xmin, xmax, Nx);
z = linspace(zmin, zmax, Nz);
[X,Z] = ndgrid(x,z); Y = zeros(size(X));
[k3d(1),k3d(2),k3d(3)] = Sph2Cart(k, k_th, k_ph);
Psi = coulomb_plane(k3d,X,Y,Z,ZZ,Sign);

figure; surf(X,Y,Z,abs(Psi));
shading interp;
xlabel x; ylabel y; zlabel z;
axis equal; axis([xmin,xmax,-1,1,zmin,zmax]);
view(0,0); caxis([0,0.16]);

figure; surf(X,Y,Z,angle(Psi));
shading interp;
xlabel x; ylabel y; zlabel z;
axis equal; axis([xmin,xmax,-1,1,zmin,zmax]);
view(0,0);
