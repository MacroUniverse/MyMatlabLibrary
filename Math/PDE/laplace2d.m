% relax method to solve
close all;
xmin = -5; xmax = 5; Nx = 500;
ymin = -5; ymax = 5; Ny = 500;
R = 0.5; dR = 0.01;
Niter = 20000;
[X, Y] = ndgrid(linspace(xmin, xmax, Nx), linspace(ymin, ymax, Ny));
r = sqrt(X.^2 + Y.^2);
U = zeros(Nx, Ny);
mask = (r >= R - dR) & (r <= R + dR);
for ii = 1:Niter
    U(mask) = 1;
    U(2:Nx-1, 2:Ny-1) = 0.25*(U(1:Nx-2, 2:Ny-1) + U(3:Nx, 2:Ny-1) .....
                      + U(2:Nx-1, 1:Ny-2) + U(2:Nx-1, 3:Ny));
    if mod(ii, 10) == 0
        disp(ii);
    end
end
imagesc(U); axis equal;

