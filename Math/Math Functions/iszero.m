% test if x is a zero of fun
% x has have an error smaller than xTol
function out = iszero(fun, x, xTol)
if nargin < 3
    xTol = x*eps*10;
end

% make sure xTol is large enough
y1 = fun(x-2*xTol);
y2 = fun(x-xTol);
y3 = fun(x+xTol);
y4 = fun(x+2*xTol);
for i = 1:1000
    if (y2*y3 < 0 && abs(y2-y1) > 0 && abs(y4-y3) > 0)
        break;
    end
    xTol = xTol * 2;
    y1 = fun(x-2*xTol);
    y2 = fun(x-xTol);
    y3 = fun(x+xTol);
    y4 = fun(x+2*xTol);
end
if i >= 999
    error('unknown!');
end

if abs(y3-y2)/max(abs(y2-y1),abs(y4-y3)) < 20
    out = true;
else
    out = false;
end
end
