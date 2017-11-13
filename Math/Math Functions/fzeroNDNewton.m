% zero minimum finder, for smooth function
% Newton's method.

function x = fzeroNDNewton(f, x0)
N = numel(x0);
x = x0;
for ii = 1:1000
    fval = f(x);
    if fval < 1e-13
        break
    end
    Df = gradian(f,x,N);
    slope = sqrt(sum(Df.^2));
    Dir = - sign(fval)* Df / slope;
    step = fval / slope;
    x = x + step*Dir;
end
end

function Df = gradian(f,x,N)
eps = 0.5e-5; % most accurate derivative.
eps2 = eps*2;
Df = zeros(1,N);
for ii = 1:N
    xp = x; xm = x;
    xp(ii) = xp(ii) + eps; 
    xm(ii) = xm(ii) - eps;
    Df(ii) = (f(xp) - f(xm))/eps2;
end
end