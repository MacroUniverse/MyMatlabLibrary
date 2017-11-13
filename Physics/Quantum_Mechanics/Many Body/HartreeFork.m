% Hartree-Fork method to solve coupled harmonic 3D oscillator
% see QM2 HW9 P3
% Used potential interpolation, not very efficient.
% need improvement

function HartreeFork
global Nx xspan psi0 m xV lambda Espan EResolution
close all;
lambda = 0.03;
Niter = 10;
EResolution = 2; % #-1 of intervals for bisection
Nx = 1000; % Number of grid points.
xspan = [0, 6];  % interval of x
psi0 = [0; 1];
m=1; % mass
Espan = [1-0.01,1+sqrt(1+2*lambda^2)+0.01]*3/2;

x = linspace(xspan(1),xspan(2),Nx);
% Initial wave function (scaled), 3D SHO
% Note that Normalization factor is different from 1D
R0 = (1/pi)^0.25*2*x.*exp(-0.5*x.^2);
I = trapz(x,R0.^2.*x.^2);
Veff = 0.5*lambda^2*(x.^2 + I);
xV = [x; Veff];

figure(1);
plot(x,R0./x); hold on;
axis([x(1),x(end),-0.2,1.8]);
xlabel('r'); ylabel('radial WF (unscaled)');
for ii = 1:Niter
    [R,E] = bound_shooting;
    figure(1); plot(x,R./x);
    E0 = 2*E - trapz(x,R.^2.*Veff);
    disp('E,E_total'); disp([E,E0]);
    I = trapz(x,R.^2.*x.^2);
    Veff = 0.5*lambda^2*(x.^2 + I);
    xV = [x; Veff];
end

end


%% solve the bound state eigen pairs of 1D potential

function [psi,Ebound] = bound_shooting
global Espan EResolution

 % initial condition [psi; psi'].

% find the zeros in Psi(x_max) vs E plot
Ebound = fzeroN(@trial, Espan, EResolution);

[~, x, psi] = trial(Ebound(1));
psi = psi/sqrt(trapz(x,abs(psi).^2)); % normalize (scaled WF)

%    hold on; plot(x, 0.5*cos(x-x0));
end


% solve psi for specific E
% psi(1,:) is the wave function, psi(2,:) is derivative
% out is either Psi(x_max) or Psi'(x_max), change in code.
function [out, x, psi] = trial(E)
global Nx xspan psi0
if nargout == 1
    psi = odeRK4(@(x,psi)D(x,psi,E), xspan, psi0, Nx);
else
    [psi, x] = odeRK4(@(x,psi)D(x,psi,E), xspan, psi0, Nx);
end
out = psi(1,end); 
psi = psi(1,:);
end

% ode file
% if psi = [psi(x); psi'(x)] is known, find Dpsi(x) = [psi'(x), psi''(x)];
function Dpsi =D(x,psi,E)
global m xV
% xV is the potential table, first row for x, second row for V
V = 0.5*x^2 + interp1(xV(1,:),xV(2,:),x);
Dpsi(2,1) = - 2*m*(E-V)*psi(1);
Dpsi(1) = psi(2);
end

% Using the Runge-Kutta method to solve differential equation
% f is the function handle that gives the derivative of Y from t and Y: dY/dt=f(t,Y)
% dt > 0 is the step length
% t starts at tspan(1) and ends at tspan(2).
% Y is the vector of all the variables depending on time
% Y0 is the initial values of Y at t=tspan(1) if tspan(1)< tspan(2)
% tspan(2) can be less than tspan(1), in which case Y0 is Y at t=tspan(2)

function [Y,t]=odeRK4(f,tspan,Y0,Nt)

Nvar=numel(Y0);  % number of variables
dt=(tspan(2)-tspan(1))/(Nt-1); % step length changed to integer division of domain
Y=zeros(Nvar,Nt);
Y(:,1)=Y0(:);
t=linspace(tspan(1),tspan(2),Nt);

for ii=1:Nt-1
    K1=f( t(ii),        Y(:,ii)          );
    K2=f( t(ii)+dt/2,   Y(:,ii)+K1*dt/2  );
    K3=f( t(ii)+dt/2,   Y(:,ii)+K2*dt/2  );
    K4=f( t(ii)+dt,     Y(:,ii)+K3*dt    );
    
    Y(:,ii+1)=Y(:,ii)+dt/6*(K1+2*K2+2*K3+K4);
end
end

%Find the roots using bisection method in many small intervals
%fun is the function to be found 0
%interval is the total interval to find roots
%resolution-1 is the number of intervals to use bisection

function roots=fzeroN(fun,interval,resolution)

x=linspace(interval(1),interval(end), resolution);
y=arrayfun(fun,x);
figure; plot(x,y,'+-')
title('the function to be find zeros of')
Sign=sign(y);
ind=find(Sign(1:end-1).*Sign(2:end)<0);

roots=zeros(size(ind));
for ii=1:numel(ind)
    roots(ii)=fzero(fun,[x(ind(ii)),x(ind(ii)+1)]);  % bisection method
end
end
