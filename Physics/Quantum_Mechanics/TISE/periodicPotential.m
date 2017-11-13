% using sqrt(2/(x2-x1))*sin(2*pi*n*(x-x1)/(x2-x1)) (and  cos) basis to solve 1D periodic potential
% symmetry is of potential is not required.
% results are the same with RK4 method.
% the conclusion is the nodes will still increase one by one.

function periodicPotential
close all;
global x1 x2 L
x1 = -pi; x2 = pi; L = x2-x1;
Vfun = @(x) 0.5*cos(x);
N = 41; % number of basis
NPlotX = 300;
NPlotPsi = 1;

% kinetic matrix
temp = floor(linspace(1,(N+1)/2,N)+0.01);
temp = [0 temp(1:end-1)];
T = diag(2*pi^2*temp.^2/L^2);
% potential matrix
V = zeros(N,N);
for ii = 1:N
for jj = ii:N
    integrand = @(x)Basis(ii,x).*Basis(jj,x).*Vfun(x);
    V(ii,jj) = integral(integrand, x1,x2,'RelTol',1e-14);
    V(jj,ii) = V(ii,jj);
end
end
H = T+V;
[Coeff,D] = eig(H); Energies = diag(D)';
disp('Energies')
disp(Energies(1:NPlotPsi));
Psi = zeros(N,NPlotX);
x = linspace(x1,x2,NPlotX);
for ii = 1:NPlotPsi
    for jj = 1:N
        Psi(ii,:) = Psi(ii,:) + Coeff(jj,ii)*Basis(jj,x);
    end
    if Psi(ii,round(NPlotX/2)) < 1e-5, Psi(ii,:) = -Psi(ii,:); end
    figure; plot(x,Psi(ii,:)); title(['E=',num2str(Energies(ii))]);
end
end

function y = Basis(n,x)
global L
n = n - 1;
if n == 0
    y = sqrt(1/L)*ones(size(x));
elseif mod(n,2) == 1
    n = (n+1)/2;
    y = sqrt(2/L)*sin(2*pi*n*x/L);
else
    n = n/2;
    y = sqrt(2/L)*cos(2*pi*n*x/L);
end
end

%function out = Vfun(x)
%out = zeros(size(x));
%out (abs(x)>pi/2) = 30;
%end