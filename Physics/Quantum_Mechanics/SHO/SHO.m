close all;

f0 = @(u) exp(-u.^2./2);
f1 = @(u) sqrt(2)*u.*exp(-u.^2./2);
f2 = @(u) 1/sqrt(2)*(2*u.^2-1).*exp(-u.^2./2);
f3 = @(u) 1/sqrt(3)*u.*(2*u.^2-3).*exp(-u.^2./2);

[X,Y] = ndgrid(linspace(-3,3,500),linspace(-3,3,500));

FigPosition = [100,100,500,500];
% Plot Boson States
figure('Position',FigPosition);
surface(X, Y, f0(X).*f0(Y)); shading flat; axis square;
colorbar; xlabel '\alpha x'; ylabel '\alpha y'; title '\psi_{00}';
figure('Position',FigPosition);
surface(X, Y, (f0(X).*f1(Y)+f1(X).*f0(Y))/sqrt(2)); shading flat; axis square;
colorbar; xlabel '\alpha x'; ylabel '\alpha y'; 
title('$$(\psi_{01}+\psi_{10})/ \sqrt 2$$','Interpreter','latex');
figure('Position',FigPosition);
surface(X, Y, (f0(X).*f2(Y)+f2(X).*f0(Y))/sqrt(2)); shading flat; axis square;
colorbar; xlabel '\alpha x'; ylabel '\alpha y';
title('$$(\psi_{02}+\psi_{20})/ \sqrt 2$$','Interpreter','latex');

% Plot Fermion States
figure('Position',FigPosition);
surface(X, Y, (f0(X).*f1(Y)-f1(X).*f0(Y))/sqrt(2)); shading flat; axis square;
colorbar; xlabel '\alpha x'; ylabel '\alpha y';
title('$$(\psi_{01}-\psi_{10})/ \sqrt 2$$','Interpreter','latex');
figure('Position',FigPosition);
surface(X, Y, (f0(X).*f2(Y)-f2(X).*f0(Y))/sqrt(2)); shading flat; axis square;
colorbar; xlabel '\alpha x'; ylabel '\alpha y';
title('$$(\psi_{02}-\psi_{20})/ \sqrt 2$$','Interpreter','latex');
figure('Position',FigPosition);
surface(X, Y, (f0(X).*f3(Y)-f3(X).*f0(Y))/sqrt(2)); shading flat; axis square;
colorbar; xlabel '\alpha x'; ylabel '\alpha y';
title('$$(\psi_{03}-\psi_{30})/ \sqrt 2$$','Interpreter','latex');
figure('Position',FigPosition);
surface(X, Y, (f1(X).*f2(Y)-f2(X).*f1(Y))/sqrt(2)); shading flat; axis square;
colorbar; xlabel '\alpha x'; ylabel '\alpha y';
title('$$(\psi_{12}-\psi_{21})/ \sqrt 2$$','Interpreter','latex');