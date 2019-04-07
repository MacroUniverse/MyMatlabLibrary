% solving the bound states using finite differences
% Nx includes the boundary points (psi = 0)
% V is a function @(x)
% output psi(:,i) is the eigen state with energy Eng(i)

function [Eng, psi, x] = bound1D(mass, xmin, xmax, Nx, V)
x = linspace(xmin, xmax, Nx);
dx = (xmax - xmin)/(Nx - 1);
% second derivative matrix (no boundary)
D2 = D2mat(Nx-2, dx);
% hamiltonian H (no boundary)
H = -D2/(2*mass);
for i = 1:Nx-2
    H(i,i) = H(i,i) + V(x(i+1));
end
[psi, Eng] = Eig(H, 'ascend');
psi = [zeros(1,size(psi,2)); psi; zeros(1,size(psi,2))];
Eng = diag(Eng);
end
