% demonstration of fr2_coulomb() function
% see CulmWf_eq10

close all;

%% spherical coordinates
k = 0;
for l0 = 0:30
    for m0 = -30:30
        if abs(m0) <= l0
            k = k + 1;
            l(k) = l0; m(k) = m0;
        end
    end
end
ZZ = 1;
rmax = 10; Nr = 100;
Sign = -1;
r = linspace(0,rmax,Nr);
k = 1;
k_th = pi/4; k_ph = 0;
% fr2 = fr2_coulomb(l,m,r,k,k_th,k_ph,ZZ,Sign);

th = linspace(0,2*pi,400); ph = 0;
[f1, R, Th, Ph] = fr2_eval(fr2,l,m,r,th,ph,true);
figure('WindowState', 'maximized'); subplot(1, 2, 1);
surfSph(R,Th,Ph,abs(f1));
view(0,0); caxis([0,0.16]);

subplot(1, 2, 2); surfSph(R,Th,Ph,angle(f1));
xlabel x; ylabel y; zlabel z;
view(0,0);


%% cartesian coordinates
xmin = -rmax; xmax = rmax; Nx = 100;
zmin = -rmax; zmax = rmax; Nz = 100;
x = linspace(xmin, xmax, Nx);
z = linspace(zmin, zmax, Nz);
[X,Z] = ndgrid(x,z); Y = zeros(size(X));
[k3d(1),k3d(2),k3d(3)] = Sph2Cart(k, k_th, k_ph);
% Psi = coulomb_plane(k3d,X,Y,Z,ZZ,Sign);

figure('WindowState', 'maximized'); subplot(1, 2, 1);
cameratoolbar;
surf(X,Y,Z,abs(Psi));
shading interp;
xlabel x; ylabel y; zlabel z;
axis equal; axis([xmin,xmax,-1,1,zmin,zmax]);
view(0,0); caxis([0,0.16]);

subplot(1, 2, 2); surf(X,Y,Z,angle(Psi));
shading interp;
xlabel x; ylabel y; zlabel z;
axis equal; axis([xmin,xmax,-1,1,zmin,zmax]);
view(0,0);
