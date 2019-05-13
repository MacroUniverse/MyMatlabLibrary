% solve scattering states of 2 coupled 1D TISE
% -1/(2*mass)*y1'' + V11*y1 + V12*y2 = E*y1
% -1/(2*mass)*y2'' + V21*y2 + V22*y2 = E*y2
% V is the 2x2 coupling matrix, V{i,j} is a function handle

% If both channels are open, shoot from the left, there are 2 linearly
% independent solutions. If only one is open, shoot from both left and
% right, then match at 'xmid', there will be only one solution

% Psi(1:2,:) are two channel wave functions
% Psi(3:4,:) are derivatives of Psi(1:2,:)

% using fixed step Runge-Kutta solver, 'xmid' will be adjusted to the
% closest grid point
function [x, Psi1, Psi2] = scatter_shooting_2ch(E,V,xmin,xmid,xmax,mass,Nx)
dy = 1e-16; % dy is psi(xmin) and psi(xmax)

if E > V{1,1}(xmax)
    % both channels are open
    [x, Psi1, Psi2] = shooting_left(E,V,xmin,xmax,mass,dy,Nx);
    return;
end

% one channel open
x = linspace(xmin, xmax, Nx);
mid_ind = lookupL(x,xmid);
xmid = x(mid_ind);

[xL,PsiL1,PsiL2] = shooting_left(E,V,xmin,xmid,mass,dy,mid_ind);

[xR,PsiR1,PsiR2,PsiR3] = shooting_right_1ch(E,V,xmid,xmax,mass,dy,Nx-mid_ind+1);

% match
C = null([-PsiL1(:,end),-PsiL2(:,end),PsiR1(:,end),PsiR2(:,end),PsiR3(:,end)]);
if (size(C,2) > 1)
    error('matrix degenerate!');
end

% combine
x = [xL(1,1:end-1), fliplr(xR)];
Psi1 = [C(1)*PsiL1(:,1:end-1) + C(2)*PsiL2(:,1:end-1),...
    fliplr(C(3)*PsiR1(:,:) + C(4)*PsiR2(:,:) + C(5)*PsiR3(:,:))];
Psi1 = Psi1 / max(max(abs(Psi1(1:2,:))));
Psi2 = [];
end

% shooting from right, only 1 channel open
% assuming V{1,1}(xmax) > V{2,2}(xmax)
function [x,Psi1,Psi2,Psi3] = shooting_right_1ch(E,V,xmin,xmax,mass,dy,Nx)
Dx = 0.1; % make independent after propagating every Dx

if ~(E < V{1,1}(xmax) && E > V{2,2}(xmax))
    error('illegal energy!');
end

x = linspace(xmax,xmin,Nx);
Psi1 = zeros(4,Nx); Psi2 = Psi1; Psi3 = Psi1;

odefun = @(x,Y) TISE_odefun(x,Y,E,V,mass);

dx = (xmax-xmin)/(Nx-1);
Nx1 = round(Dx/dx) + 1;
Dx = dx * (Nx1-1);
x0 = xmax; xnext = x0 - Dx;

% first propagation
ind1 = 1; ind2 = Nx1;
Y0 = [1; 0; -sqrt(2*mass*(V{1,1}(xmax) - E)); 0] * dy;
Psi1(:,ind1:ind2) = odeRK4(odefun, [x0,xnext], Y0, Nx1);

k = sqrt(2*mass*(E - V{2,2}(xmax)));
Y0 = [0; sin(k*xmax); 0; k*cos(k*xmax)];
Psi2(:,ind1:ind2) = odeRK4(odefun, [x0,xnext], Y0, Nx1);

Y0 = [0; cos(k*xmax); 0; -k*sin(k*xmax)];
Psi3(:,ind1:ind2) = odeRK4(odefun, [x0,xnext], Y0, Nx1);
x0 = xnext;

while true
    % make independent
    if abs(Psi2(1,ind2)) > 10
        Psi2(:,1:ind2) = Psi2(:,1:ind2) - Psi2(1,ind2)/Psi1(1,ind2)*Psi1(:,1:ind2);
    end
    if abs(Psi3(1,ind2)) > 10
        Psi3(:,1:ind2) = Psi3(:,1:ind2) - Psi3(1,ind2)/Psi1(1,ind2)*Psi1(:,1:ind2);
    end
    % plot debug
    %figure(3); plot(x(1:ind2), Psi1(1:2,1:ind2));
    %figure(4); plot(x(1:ind2), Psi2(1:2,1:ind2));
    %figure(5); plot(x(1:ind2), Psi3(1:2,1:ind2));
    
    % propagate again
    ind1 = ind2; ind2 = ind1+(Nx1-1);
    if ind2 > Nx
        break;
    end
    xnext = x0 - Dx;
    Psi1(:,ind1:ind2) = odeRK4(odefun, [x0,xnext], Psi1(:,ind1), Nx1);
    Psi2(:,ind1:ind2) = odeRK4(odefun, [x0,xnext], Psi2(:,ind1), Nx1);
    Psi3(:,ind1:ind2) = odeRK4(odefun, [x0,xnext], Psi3(:,ind1), Nx1);
    x0 = xnext;
end

% propagate the rest
Nx1 = Nx - ind1 + 1;
Psi1(:,ind1:end) = odeRK4(odefun, [x0,xmin], Psi1(:,ind1), Nx1);
Psi2(:,ind1:end) = odeRK4(odefun, [x0,xmin], Psi2(:,ind1), Nx1);
Psi3(:,ind1:end) = odeRK4(odefun, [x0,xmin], Psi3(:,ind1), Nx1);

% max normalize
Psi1 = Psi1 / max(max(abs(Psi1(1:2,:))));
Psi2 = Psi2 / max(max(abs(Psi2(1:2,:))));
Psi3 = Psi3 / max(max(abs(Psi3(1:2,:))));
end

% shooting from the left
function [x, Psi1, Psi2] = shooting_left(E, V, xmin, xmax, mass, dy, Nx)
Dx = 0.1; % make independent after propagating every Dx

if ~(E < min(V{1,1}(xmin), V{2,2}(xmin)))
    error('illegal energy!');
end
x = linspace(xmin,xmax,Nx);
Psi1 = zeros(4,Nx); Psi2 = Psi1;

odefun = @(x,Y) TISE_odefun(x,Y,E,V,mass);

dx = (xmax-xmin)/(Nx-1);
Nx1 = round(Dx/dx) + 1;
Dx = dx * (Nx1-1);
x0 = xmin; xnext = x0 + Dx;
ind1 = 1; ind2 = Nx1;

Y0 = [1; 0; sqrt(2*mass*(V{1,1}(xmin) - E)); 0] * dy;
Psi1(:,ind1:ind2) = odeRK4(odefun, [x0,xnext], Y0, Nx1);

Y0 = [0; 1; 0; sqrt(2*mass*(V{2,2}(xmin) - E))] * dy;
Psi2(:,ind1:ind2) = odeRK4(odefun, [x0,xnext], Y0, Nx1);
x0 = xnext;

while 1
    % plot debug
    %figure(1); plot(x(1:ind2), Psi1(1:2,1:ind2));
    %figure(2); plot(x(1:ind2), Psi2(1:2,1:ind2));
    
    % make linear independent
    if E < V{2,2}(xnext) && abs(Psi1(1,ind2)/Psi1(2,ind2)) < 10
        Psi1(:,1:ind2) = Psi1(:,1:ind2) - Psi1(2,ind2)/Psi2(2,ind2) * Psi2(:,1:ind2);
    end
    if E < V{1,1}(xnext) && abs(Psi2(2,ind2)/Psi2(1,ind2)) < 10
        Psi2(:,1:ind2) = Psi2(:,1:ind2) - Psi2(1,ind2)/Psi1(1,ind2) * Psi1(:,1:ind2);
    end
    % plot debug
    %figure(1); plot(x(1:ind2), Psi1(1:2,1:ind2));
    %figure(2); plot(x(1:ind2), Psi2(1:2,1:ind2));
    
    % propagate again
    xnext = x0 + Dx;
    ind1 = ind2; ind2 = ind1 + Nx1 - 1;
    if ind2 > Nx || E > max(V{1,1}(xnext), V{2,2}(xnext))
        break;
    end
    Psi1(:,ind1:ind2) = odeRK4(odefun, [x0,xnext], Psi1(:,ind1), Nx1);
    Psi2(:,ind1:ind2) = odeRK4(odefun, [x0,xnext], Psi2(:,ind1), Nx1);
    x0 = xnext;
end

% final propagation
Nx1 = Nx - ind1 + 1;
Psi1(:,ind1:end) = odeRK4(odefun, [x0,xmax], Psi1(:,ind1), Nx1);
Psi2(:,ind1:end) = odeRK4(odefun, [x0,xmax], Psi2(:,ind1), Nx1);

% max normalize
Psi1 = Psi1 / max(max(abs(Psi1(1:2,:))));
Psi2 = Psi2 / max(max(abs(Psi2(1:2,:))));
end

function dY = TISE_odefun(x, Y, E, V, mass)
Y1 = Y(1); Y2 = Y(2); dY1 = Y(3); dY2 = Y(4);
V11 = V{1,1}(x); V12 = V{1,2}(x);
V21 = V{2,1}(x); V22 = V{2,2}(x);
ddY1 = 2*mass*( (V11-E)*Y1 +     V12*Y2);
ddY2 = 2*mass*(     V21*Y1 + (V22-E)*Y2);
dY = [dY1;dY2;ddY1;ddY2];
end
