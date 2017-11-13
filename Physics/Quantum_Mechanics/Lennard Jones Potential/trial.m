%'out' is the difference of the slope of phi1 and ph2 at x_mid
%Y1 is the wave function of [xspan(1) x_mid]
%Y2 is the wave function of [xspan(2) x_mid]
%Y(1,:) is the wave function, Y(2,:) is the derivative

function [dSlope,x1,Y1,x2,Y2]=trial(E,V,xspan,x_mid,epsilon,dx)

% 'f' describes the ode system of TDSE
f=@(x,Y) BoundOde(x,Y,V,E);

% set initial value
if V(xspan(1))-E <=0
    error('E>V at left boundary');
elseif sqrt(2*(V(xspan(2))-E))<=0
    error('E>V at right boundary');
end
Y01=[epsilon; epsilon*sqrt(2*(V(xspan(1))-E))];
Y02=[epsilon; -epsilon*sqrt(2*(V(xspan(2))-E))];

% solve f using 4th order Runge-Kutta method
[Y1,x1]=odeRK4(f,[xspan(1),x_mid],Y01,dx);
[Y2,x2]=odeRK4(f,[xspan(2),x_mid],Y02,dx);
Y1=Y1(1,:); Y2=Y2(1,:);

% normalize Y2 to be continueous with Y1 at x_mid
Y2=Y2/Y2(end)*Y1(end);

% figure
% plot(x1,Y1);
% hold on
% plot(x2,Y2);

dSlope=(Y2(end-1)-Y2(end))-(Y1(end)-Y1(end-1));

end