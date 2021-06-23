% coulomb plane demo

Nx = 200; Ny = 200;
k = [0, 1, 0];
a = 60;
Z = zeros(Nx, Ny);
x = linspace(-a, a, Nx);
y = linspace(-a, a, Ny);
[X, Y] = ndgrid(x, y);
Val = coulomb_plane(k, X, Y, Z, -5, +1);
figure; surf(X, Y, Z, real(Val));
xlabel x; ylabel y;
view(0, 90);
colormap jet;
shading flat;
cameratoolbar;
set(datacursormode(gcf), 'UpdateFcn', @datatip);
figure; surf(X, Y, Z, imag(Val));
xlabel x; ylabel y;
view(0, 90);
colormap jet;
shading flat;
cameratoolbar;
set(datacursormode(gcf), 'UpdateFcn', @datatip);


Nx = 200; Ny = 200;
k = [0, -1, 0];
a = 60;
Z = zeros(Nx, Ny);
x = linspace(-a, a, Nx);
y = linspace(-a, a, Ny);
[X, Y] = ndgrid(x, y);
Val = coulomb_plane(k, X, Y, Z, -5, -1);
figure; surf(X, Y, Z, real(Val));
xlabel x; ylabel y;
view(0, 90);
colormap jet;
shading flat;
cameratoolbar;
set(datacursormode(gcf), 'UpdateFcn', @datatip);
figure; surf(X, Y, Z, -imag(Val));
xlabel x; ylabel y;
view(0, 90);
colormap jet;
shading flat;
cameratoolbar;
set(datacursormode(gcf), 'UpdateFcn', @datatip);
