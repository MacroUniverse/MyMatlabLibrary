% solve the bound state eigen pairs of 1D potential

function bound_shooting
global Nx xspan psi0 m
close all;
m=1; % mass
psi0 = [0; 1]; % initial condition [psi; psi'].
Nx = 600; % Number of grid points.
xspan = [0, 2*pi];  % interval of x
Espan = [-0.5,1]; % interval of E
EResolution = 10; % number os intervals for bisection

% find the zeros in Psi(x_max) vs E plot
Ebound = fzeroN(@trial, Espan, EResolution);

% output and plot.
disp('Energies'); disp(Ebound);
Psi = zeros(numel(Ebound),Nx);
for ii = 1:numel(Ebound)
    [~, x, psi] = trial(Ebound(ii));
    psi = psi/max(psi);
    figure; plot(x,psi); axis([x(1),x(end),-1,1]);
    xlabel('x'); ylabel('\psi(x)');
    title(['E=',num2str(Ebound(ii))]);
    Psi(ii,:) = psi;
%    hold on; plot(x, 0.5*cos(x-x0));
end
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
global m
V = 0.5*cos(x);
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
