% output matching error determined by Wronskian
% [psi_left, psi_left', psi_right; psi_right']
% at xmid, psi normalized to max(psi) = 1
function [err, x, psi] = bound_shooting_trial(E, V, xmin, xmid, xmax, mass, odeOpt)
dy = 1e-16; % dy is psi(xmin) and psi(xmax)
[x1, Y1] = bound_shooting_left(E, V, [xmin,xmid], mass, dy, odeOpt);
[x2, Y2] = bound_shooting_right(E, V, [xmax,xmid], mass, dy, odeOpt);

% error
err = fmatch_err(Y1(end,1),Y1(end,2),Y2(end,1),Y2(end,2));

psi1_max = max(abs(Y1(:,1)));
psi2_max = max(abs(Y2(:,1)));

% wave function (max(psi) = 1)
if nargout > 1
    x = [x1; flip(x2(1:end-1))].';
end
if nargout > 2
    v1 = Y1(end,:);
    v2 = Y2(end,:);
    scale = sign(dot(v1,v2))*norm(v1)/norm(v2);
    if psi1_max >= psi2_max * abs(scale)
        psi = [
            Y1(:,1).' / psi1_max,  .....
            flip(Y2(1:end-1,1)).' * (scale / psi1_max)];
    else
        psi = [
            Y1(:,1).' / (scale * psi2_max),  .....
            flip(Y2(1:end-1,1)).' / psi2_max];
    end
end
end

% solve TISE by shooting from one end of the potential to a middle point
% the middle point xspan(2) should be in classically allowed region
% varargin are options for ode45 solver
% dy is psi(xmin) and psi(xmax)
function [x, Y] = bound_shooting_left(E, V, xspan, mass, dy, odeOpt)
if V(xspan(1)) > E
    Y0 = [1; sqrt(2*mass*(V(xspan(1)) - E))] * dy;
else
    Y0 = [0; 1];
end
odefun = @(x,Y) TISE_odefun(x,Y,E,V,mass);
[x,Y] = ode45(odefun, xspan, Y0, odeOpt);
end

function [x, Y] = bound_shooting_right(E, V, xspan, mass, dy, odeOpt)
if V(xspan(1)) > E
    Y0 = [1; -sqrt(2*mass*(V(xspan(1)) - E))] * dy;
else
    Y0 = [0; 1];
end
odefun = @(x,Y) TISE_odefun(x,Y,E,V,mass);
[x,Y] = ode45(odefun, xspan, Y0, odeOpt);
end

% ode function
% if Y = [psi(x); psi'(x)] is known, find dY(x) = [psi'(x), psi''(x)];
function dY =TISE_odefun(x,Y,E,V,mass)
dY(2,1) = - 2*mass*(E-V(x))*Y(1);
dY(1) = Y(2);
end
