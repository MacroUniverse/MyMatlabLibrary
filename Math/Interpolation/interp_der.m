% get derivative by getting interpolation
function dydx = interp_der(x, y, xq)
dx = 1e-7; % finite diff step
N = numel(xq);
for ii = 1:N
    dydx = (spline(x,y,xq+dx)-spline(x,y,xq))/dx;
end
end
