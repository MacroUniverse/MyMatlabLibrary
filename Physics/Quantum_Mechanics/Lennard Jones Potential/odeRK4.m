% Using the Runge-Kutta method to solve differential equation
% f is the function handle that gives the derivative of Y from t and Y: dYdt=f(t,Y)
% dt>0 is the step length
% t starts at tspan(1) and ends at tspan(2).
% Y is the vector of all the variables depending on time
% Y0 is the initial values of Y at t=tspan(1) if tspan(1)< tspan(2)
% tspan(2) can be less than tspan(1), in which case Y0 is Y at t=tspan(2)

function [Y,t]=odeRK4(f,tspan,Y0,dt)

Nvar=numel(Y0);  % number of variables
Nt=ceil(abs(tspan(2)-tspan(1))/dt)+1; % number of data points for each variable
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