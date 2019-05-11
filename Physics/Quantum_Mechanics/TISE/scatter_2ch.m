% like bound_shooting_trial, but for 2 coupled 1D TISE equations
% coupled only via V matrix
% V is a 2x2 cell array of function handles

% solve TISE by shooting from both end of the potential to a middle point
% the middle point should be in classically allowed region
% varargin are options for ode45 solver
% dy is psi(xmin) and psi(xmax)

function scatter_2ch...
    (E, V, xmin, xmid, xmax, mass, Nx)
dy = 1e-16; % dy is psi(xmin) and psi(xmax)

if E < V{1,1}(xmax)
    % one channel open
    [x, Psi] = shooting_ch2_open(E,V,xmin,xmid,xmax,mass,dy,Nx);
    figure; plot(x, Psi);
else
    % both channels open
    [x1, Psi1, x2, Psi2] = ...
        shooting_both_open(E, V, xmin, xmax, mass, dy, Nt);
    figure; plot(x1, Psi1);
    figure; plot(x2, Psi2);
end
end

% only 1 channel open
% assuming V{1,1}(xmax) > V{2,2}(xmax)
% Psi(1,:) is first channel wave function
% Psi(2,:) is second channel wave function
function [x, Psi] = shooting_ch2_open(E,V,xmin,xmid,xmax,mass,dy,Nx)
if ~(E < min([V{1,1}(xmin), V{2,2}(xmin), V{1,1}(xmax)])...
        && E > V{1,1}(xmax))
    error('illegal energy!');
end
odefun = @(x,Y) TISE_odefun(x,Y,E,V,mass);

% left
Y0 = [1; 0; sqrt(2*mass*(V{1,1}(xmin) - E)); 0] * dy;
[xL,YL1] = odeRK4(odefun, [xmin,xmid], Y0, Nx);

Y0 = [0; 1; 0; sqrt(2*mass*(V{2,2}(xmin) - E))] * dy;
[~,YL2] = odeRK4(odefun, [xmin,xmid], Y0, Nx);

% right
Y0 = [1; 0; -sqrt(2*mass*(V{1,1}(xmax) - E)); 0] * dy;
[xR,YR1] = odeRK4(odefun, [xmax,xmid], Y0, Nx);

Y0 = [0; sin(xmax); 0; cos(xmax)];
[~,YR2] = odeRK4(odefun, [xmax,xmid], Y0, Nx);

Y0 = [0; cos(xmax); 0; -sin(xmax)];
[~,YR3] = odeRK4(odefun, [xmax,xmid], Y0, Nx);

% match
C = null([-YL1(:,end), -YL2(:,end), YR1(:,end), YR2(:,end), YR3(:,end)]);
if (size(C,2) > 1)
    error('matrix degenerate!');
end

% combine
x = [xL(1,1:end-1), fliplr(xR)];
Psi = [C(1)*YL1(1:2,1:end-1) + C(2)*YL2(1:2,1:end-1),...
    fliplr(C(3)*YR1(1:2,:) + C(4)*YR2(1:2,:) + C(5)*YR1(1:2,:))];
end

% both channels are open
% Psi(1,:) is first channel wave function
% Psi(2,:) is second channel wave function
function [x1, Psi1, x2, Psi2] = ...
    shooting_both_open(E, V, xmin, xmax, mass, dy, Nt)
if ~(E < min(V{1,1}(xmin), V{2,2}(xmin))...
        && E > max(V{1,1}(xmax), V{2,2}(xmax)))
    error('illegal energy!');
end
Y0 = [1; 0; sqrt(2*mass*(V{1,1}(xmin) - E)); 0] * dy;
[x1,Psi1] = odeRK4(odefun, [xmin,xmax], Y0, Nt);

Y0 = [0; 1; 0; sqrt(2*mass*(V{2,2}(xmin) - E))] * dy;
[x2,Psi2] = odeRK4(odefun, [xmin,xmax], Y0, Nt);
end

function dY = TISE_odefun(x, Y, E, V, mass)
Y1 = Y(1); Y2 = Y(2); dY1 = Y(3); dY2 = Y(4);
V11 = V{1,1}(x); V12 = V{1,2}(x);
V21 = V{2,1}(x); V22 = V{2,2}(x);
ddY1 = 2*mass*( (V11-E)*Y1 +     V12*Y2);
ddY2 = 2*mass*(     V21*Y1 + (V22-E)*Y2);
dY = [dY1;dY2;ddY1;ddY2];
end
