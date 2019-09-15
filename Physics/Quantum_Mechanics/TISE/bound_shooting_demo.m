close all;
% =====  params  ========
V = @(x) 0.5*x.*x;
mass = 1;
xmin = -10; xmid = 0; xmax = 10;
Espan = [0.1, 10];
Eresolution = 100;
NstepMin = 1000;
% =======================

x = linspace(xmin, xmax, 1000);
figure; plot(x, V(x));
xlabel x; title V;

[Eng, X, Psi] = bound_shooting(V, xmin, xmid, xmax, mass, Espan, ....
    Eresolution, odeset('RelTol',1e-6, 'MaxStep',abs(xmax-xmin)/NstepMin),...
	true);
