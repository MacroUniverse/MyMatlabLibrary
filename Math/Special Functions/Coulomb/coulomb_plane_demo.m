% coulomb plane demo

ZZ = 5;
k = [0, 1, 0];

Nx = 200; Ny = 200;
a = 60;
Z = zeros(Nx, Ny);
x = linspace(-a, a, Nx);
y = linspace(-a, a, Ny);
[X, Y] = ndgrid(x, y);
Val = coulomb_plane(k, X, Y, Z, ZZ, +1);

figure('WindowState', 'maximized');
subplot(1, 2, 1);
surf(X, Y, Z, real(Val));
title(['Z=' num2str(ZZ) ', k=' num2str(k) ', real']);
xlabel x; ylabel y;
view(0, 90);
colormap jet;
shading flat;
cameratoolbar;
set(datacursormode(gcf), 'UpdateFcn', @datatip);

subplot(1, 2, 2);
surf(X, Y, Z, imag(Val));
title(['Z=' num2str(ZZ) ', k=' num2str(k) ', imag']);
xlabel x; ylabel y;
view(0, 90);
colormap jet;
shading flat;
cameratoolbar;
set(datacursormode(gcf), 'UpdateFcn', @datatip);

%% verify conje(Psi_{-k}^-) = Psi_k^+ Psi_ is the same
Val2 = coulomb_plane(-k, X, Y, Z, ZZ, -1);

figure('WindowState', 'maximized');
subplot(1, 2, 1);
surf(X, Y, Z, real(Val2));
title(['Z=' num2str(ZZ) ', k=' num2str(-k) ', real']);
xlabel x; ylabel y;
view(0, 90);
colormap jet;
shading flat;
cameratoolbar;
set(datacursormode(gcf), 'UpdateFcn', @datatip);

subplot(1, 2, 2);
surf(X, Y, Z, -imag(Val2));
title(['Z=' num2str(ZZ) ', k=' num2str(-k) ', -imag']);
xlabel x; ylabel y;
view(0, 90);
colormap jet;
shading flat;
cameratoolbar;
set(datacursormode(gcf), 'UpdateFcn', @datatip);
