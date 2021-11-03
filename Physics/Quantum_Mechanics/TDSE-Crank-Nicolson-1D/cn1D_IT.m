% Crank–Nicolson method with imaginary time
% only need to change 1i in SE into -1
% also need to normalize the wave function at every time step
function Psi = cn1D_IT(V, xspan, tspan, psi0, Nx, Nt)
A = zeros(Nx - 2, Nx - 2); B = zeros(Nx - 2, 1);
Psi = zeros(Nx, Nt); Psi(:,1) = psi0;
x = linspace(xspan(1), xspan(2), Nx);
t = linspace(tspan(1), tspan(2), Nt);
dt = (tspan(2) - tspan(1))/Nt;
dx = (xspan(2) - xspan(1))/Nx;
a = dt/(4*dx^2);
b = dt/2;
% time evolves dt
for n = 1:Nt-1
    A(1,1) = 1 + 2*a + b*V(x(2),t(n+1));
    A(1,2) = -a;
    B(1) = (1 - 2*a - b*V(x(2),t(n)))*Psi(2,n) + a*Psi(3,n);
    A(end, end - 1) = -a;
    A(end, end) = 1 + 2*a + b*V(x(Nx-1),t(n+1));
    B(end) = a*Psi(Nx-2,n) + (1 - 2*a - b*V(x(Nx-1),t(n)))*Psi(Nx-1,n);    
    for jj = 2:Nx - 3
        A(jj, jj-1) = -a;
        A(jj, jj  ) = 1 + 2*a + b*V(x(jj+1),t(n+1));
        A(jj, jj+1) = -a;
        B(jj) = a*Psi(jj,n) + (1 - 2*a - b*V(x(jj+1),t(n)))*Psi(jj+1,n)....
                                                       + a*Psi(jj+2,n);
    end
    Psi(2:end-1, n+1) = A\B;
    Psi(:,n+1) = Psi(:,n+1)/sqrt(Psi(:,n+1)'*Psi(:,n+1)*dx);
end
end

