% 数值二阶偏导
% D^2 f / D(x_i)D(x_j)
function ret = D2_ij(f, i, j, x, h)
if i == j
    f2 = f(x);
    x(i) = x(i) + h;
    f3 = f(x);
    x(i) = x(i) - 2*h;
    f1 = f(x);
    ret = (f1 + f3 - 2*f2)/h^2;
else % i ~= j
    x(i) = x(i) - h; x(j) = x(j) - h;
    f1 = f(x);
    x(i) = x(i) + 2*h;
    f2 = f(x);
    x(j) = x(j) + 2*h;
    f3 = f(x);
    x(i) = x(i) - 2*h;
    L4 = f(x);
    ret = (f1 - f2 + f3 - L4)/(2*h)^2;
end
end
