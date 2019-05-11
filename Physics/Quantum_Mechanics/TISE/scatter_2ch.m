% like bound_shooting_trial, but for 2 coupled 1D TISE equations
% coupled only via V matrix
% V is a 2x2 cell array of function handles

% solve TISE by shooting from both end of the potential to a middle point
% the middle point should be in classically allowed region
% varargin are options for ode45 solver
% dy is psi(xmin) and psi(xmax)

function [x, Psi] = scatter_2ch(E, V, xmin, xmid, xmax, mass, Nx)
dy = 1e-16; % dy is psi(xmin) and psi(xmax)

if E > V{1,1}(xmax)
    % both channel open
    [x, YL1, YL2] = shooting_left(E,V,xmin,xmax,mass,dy,Nx);
    Psi1 = YL1(1:2,:); Psi2 = YL2(1:2,:);
    figure; plot(x, Psi1); title(['E = ' num2str(E) '  #1']);
    figure; plot(x, Psi2); title(['E = ' num2str(E) '  #2']);
    return;
end

% one channels open

% left
Nx1 = round(Nx/(xmax-xmin)*(xmid-xmin));
[xL, YL1, YL2] = shooting_left(E,V,xmin,xmid,mass,dy,Nx1);

[xR, YR1, YR2, YR3] = ...
    shooting_right_1ch(E,V,xmid,xmax,mass,dy,Nx);

% match
C = null([-YL1(:,end), -YL2(:,end), YR1(:,end), YR2(:,end), YR3(:,end)]);
if (size(C,2) > 1)
    error('matrix degenerate!');
end

% combine
x = [xL(1,1:end-1), fliplr(xR)];
Psi = [C(1)*YL1(1:2,1:end-1) + C(2)*YL2(1:2,1:end-1),...
    fliplr(C(3)*YR1(1:2,:) + C(4)*YR2(1:2,:) + C(5)*YR3(1:2,:))];

figure; plot(x, Psi); hold on;
scatter(xmid, 0);
title(['E = ' num2str(E)]);
end

% only 1 channel open
% assuming V{1,1}(xmax) > V{2,2}(xmax)
% Psi(1,:) is first channel wave function
% Psi(2,:) is second channel wave function
function [xR, YR1, YR2, YR3] = shooting_right_1ch(E,V,xmin,xmax,mass,dy,Nx)
if ~(E < V{1,1}(xmax) && E > V{2,2}(xmax))
    error('illegal energy!');
end
odefun = @(x,Y) TISE_odefun(x,Y,E,V,mass);

Dx = 0.1;
xtemp = xmax; xnext = xtemp - Dx;
Nx1 = round(Nx/(xmax-xmin)*Dx);
% Nx1 = round(Nx/(xmax-xmin)*(xmax-xmid));

Y0 = [1; 0; -sqrt(2*mass*(V{1,1}(xmax) - E)); 0] * dy;
[YR1, xR] = odeRK4(odefun, [xtemp,xnext], Y0, Nx1);

k = sqrt(2*mass*(E - V{2,2}(xmax)));
Y0 = [0; sin(k*xmax); 0; k*cos(k*xmax)];
YR2 = odeRK4(odefun, [xtemp,xnext], Y0, Nx1);

Y0 = [0; cos(k*xmax); 0; -k*sin(k*xmax)];
YR3 = odeRK4(odefun, [xtemp,xnext], Y0, Nx1);
xtemp = xnext;

while 1
    % make independent
    YR1 = YR1/YR1(1,end);
    if abs(YR2(1,end)) > 10
        YR2 = YR2 - YR2(1,end)/YR1(1,end)*YR1;
    end
    if abs(YR3(1,end)) > 10
        YR3 = YR3 - YR3(1,end)/YR1(1,end)*YR1;
    end
    % plot debug
    %figure(3); plot(xR, YR1(1:2,:));
    %figure(4); plot(xR, YR2(1:2,:));
    %figure(5); plot(xR, YR3(1:2,:));
    % propagate again
    xnext = xtemp - Dx;
    if xnext > xmin
        Y0 = YR1(:,end);
        [YR1_inc, xR_inc] = odeRK4(odefun, [xtemp,xnext], Y0, Nx1);
        Y0 = YR2(:,end);
        YR2_inc = odeRK4(odefun, [xtemp,xnext], Y0, Nx1);
        Y0 = YR3(:,end);
        YR3_inc = odeRK4(odefun, [xtemp,xnext], Y0, Nx1);
        xR = [xR(1:end-1), xR_inc];
        YR1 = [YR1(:,1:end-1), YR1_inc];
        YR2 = [YR2(:,1:end-1), YR2_inc];
        YR3 = [YR3(:,1:end-1), YR3_inc];
        xtemp = xnext;
    else
        Y0 = YR1(:,end);
        [YR1_inc, xR_inc] = odeRK4(odefun, [xtemp,xmin], Y0, Nx1);
        Y0 = YR2(:,end);
        YR2_inc = odeRK4(odefun, [xtemp,xmin], Y0, Nx1);
        Y0 = YR3(:,end);
        YR3_inc = odeRK4(odefun, [xtemp,xmin], Y0, Nx1);
        xR = [xR(1:end-1), xR_inc];
        YR1 = [YR1(:,1:end-1), YR1_inc];
        YR2 = [YR2(:,1:end-1), YR2_inc];
        YR3 = [YR3(:,1:end-1), YR3_inc];
        return;
    end
end
end

% both channels are open
% Psi1, Psi2 is 4-by-Nx matrices
function [x, Psi1, Psi2] = shooting_left(E, V, xmin, xmax, mass, dy, Nx)
if ~(E < min(V{1,1}(xmin), V{2,2}(xmin)))
    error('illegal energy!');
end
odefun = @(x,Y) TISE_odefun(x,Y,E,V,mass);

Dx = 0.05; xtemp = xmin + Dx; Nx1 = round(Nx/(xmax-xmin)*Dx);
Y0 = [1; 0; sqrt(2*mass*(V{1,1}(xmin) - E)); 0] * dy;
[Psi1, x] = odeRK4(odefun, [xmin,xtemp], Y0, Nx1);

Y0 = [0; 1; 0; sqrt(2*mass*(V{2,2}(xmin) - E))] * dy;
Psi2 = odeRK4(odefun, [xmin,xtemp], Y0, Nx1);

while E < max(V{1,1}(xtemp), V{2,2}(xtemp))
    % make linear independent
    Psi1 = Psi1 / max(Psi1(1:2,end));
    Psi2 = Psi2 / max(Psi2(1:2,end));
    % plot debug
    %figure; plot(x, Psi1(1:2,:));
    %figure; plot(x, Psi2(1:2,:));
    
    if abs(det([Psi1(1:2,end), Psi2(1:2,end)])) < 0.3
        Psi1_LI = Psi1 - Psi1(2,end)/Psi2(2,end) * Psi2;
        Psi2_LI = Psi2 - Psi2(1,end)/Psi1(1,end) * Psi1;
        Psi1 = Psi1_LI;
        Psi2 = Psi2_LI;
        % plot debug
        % figure(1); plot(x, Psi1(1:2,:));
        % figure(2); plot(x, Psi2(1:2,:));
    end
    % propagate again
    xnext = xtemp+Dx;
    if (xnext < xmax)
        Y0 = Psi1(:,end);
        [Psi1_inc, x_inc] = odeRK4(odefun, [xtemp,xnext], Y0, Nx1);
        Y0 = Psi2(:,end);
        Psi2_inc = odeRK4(odefun, [xtemp,xnext], Y0, Nx1);
        x = [x(1:end-1), x_inc];
        Psi1 = [Psi1(:,1:end-1), Psi1_inc];
        Psi2 = [Psi2(:,1:end-1), Psi2_inc];
        xtemp = xnext;
    else
        Y0 = Psi1(:,end);
        [Psi1_inc, x_inc] = odeRK4(odefun, [xtemp,xmax], Y0, Nx1);
        Y0 = Psi2(:,end);
        Psi2_inc = odeRK4(odefun, [xtemp,xmax], Y0, Nx1);
        x = [x(1:end-1), x_inc];
        Psi1 = [Psi1(:,1:end-1), Psi1_inc];
        Psi2 = [Psi2(:,1:end-1), Psi2_inc];
        return;
    end
end

% final propagation
Nx1 = round(Nx/(xmax-xmin)*(xmax-xtemp));
Y0 = Psi1(:,end);
[Psi1_inc, x_inc] = odeRK4(odefun, [xtemp,xmax], Y0, Nx1);
Y0 = Psi2(:,end);
Psi2_inc = odeRK4(odefun, [xtemp,xmax], Y0, Nx1);
x = [x(1:end-1), x_inc];
Psi1 = [Psi1(:,1:end-1), Psi1_inc];
Psi2 = [Psi2(:,1:end-1), Psi2_inc];
end

function dY = TISE_odefun(x, Y, E, V, mass)
Y1 = Y(1); Y2 = Y(2); dY1 = Y(3); dY2 = Y(4);
V11 = V{1,1}(x); V12 = V{1,2}(x);
V21 = V{2,1}(x); V22 = V{2,2}(x);
ddY1 = 2*mass*( (V11-E)*Y1 +     V12*Y2);
ddY2 = 2*mass*(     V21*Y1 + (V22-E)*Y2);
dY = [dY1;dY2;ddY1;ddY2];
end
