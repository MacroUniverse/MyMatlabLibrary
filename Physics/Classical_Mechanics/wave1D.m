% mechanical wave in 1D
% ref: http://littleshi.cn/online/W1dNum.html

function wave1D
close all;
cd([Desktop '/img']);

% ==== params ====
c = 1; % velocity
xmin = -4; xmax = 6; Nx = 1200; % space grid
tmin = 0; tmax = 12; Nt = 2401; % time grid
w = 6; Ncyc = 5; % init wave packet
bc = 'd'; % boundary condition: 'd': dirichelet, 'n': numann, 'o': open
% ================

x = linspace(xmin, xmax, Nx)';
t = linspace(tmin, tmax, Nt);
dx = (xmax - xmin)/(Nx - 1);
dt = (tmax - tmin)/(Nt - 1);
C = c*dt/dx; C2 = C*C;
y = zeros(Nx, Nt);
y(:,1) = y0(x, w, Ncyc);
y(:,2) = y0(x - c*dt, w, Ncyc);

% second difference
% boundary elements are set to 0
D2 = @(v) [0;
    (v(1:end-2) - 2*v(2:end-1) + v(3:end));
    0];

figure;
for n = 2:Nt - 1
    y(:,n+1) = 2*y(:,n) - y(:,n-1) + C2*D2(y(:,n));
    y = bc_set(y, n+1, bc, c, dx, dt);
    if (mod(n, 8) == 0)
        clf; plot(x, y(:,n+1)); axis([xmin,xmax,-2,2]);
        hold on; scatter([xmin,xmax], [y(1,n+1), y(end,n+1)]);
        if bc == 'd'
            title(['Dirichlet B.C.  t = ', num2str(t(n+1), '%.2f')]);
        elseif bc == 'n'
            title(['Neumann B.C.  t = ', num2str(t(n+1), '%.2f')]);
        else
            title(['Open B.C.  t = ', num2str(t(n+1), '%.2f')]);
        end
        xlabel x; ylabel y;
        drawnow;
        saveas(gcf, [bc 'wv' num2str(n) '.png']);
    end
end
end

% initial wave function
% sin^2 envelope
function y = y0(x, w, Ncyc)
T = 2*pi/w;
L = T*Ncyc/2;
y = zeros(size(x));
w0 = w / Ncyc / 2;
for i = 1:numel(x)
    xx = x(i);
    if abs(xx) <= L
        y(i) = cos(w0*xx)^2 * sin(w*xx);
    end
end
end

% enforce boundary condition
function y = bc_set(y, n, bc, c, dx, dt)
if bc == 'd' % dirichelet
    y(1, n) = 0;
    y(end, n) = 0;
elseif bc == 'n' % numann
    y(1, n) = y(2, n);
    y(end, n) = y(end-1, n);
elseif bc == 'o' % open
    y(end, n) = y(end-1, n) - 1/c * (y(end-1, n) - y(end-1, n-1))*dx/dt;
end
end
