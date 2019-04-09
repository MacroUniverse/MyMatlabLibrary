% bound_shooting demo
close all;
V = @(x) 0.5*x.^2; % SHO
xmin = -15; xmax = 15; xmid = 0;
mass = 1;
Espan = [0.1, 30]; % interval of E
EResolution = 100; % number of intervals for bisection
options = odeset('RelTol',1e-6);%,'AbsTol',1e-16);
[Eng, X, Psi] = bound_shooting(V, xmin, xmid, xmax, mass, Espan, ....
    EResolution, options);

for i = 1:numel(Eng)
    x = X{i}; psi = Psi{i};
    figure; plot(x,psi); axis([x(1),x(end),-1,1]);
    xlabel('x'); ylabel('\psi(x)');
    title(['E=',num2str(Eng(i))]);
end

% also works for infinite square well
% V = @(x) 0;
% xmin = -pi/2; xmax = pi/2; xmid = 0;
% Espan = [-0.5,30]; 
