% 数值二阶偏导
% digi 是结果的有效数字
% D^2 f / D(x_i)D(x_j)
function [ret, digi] = D2_ij(f, i, j, x, h)
if i == j
    h = (x(i) + h) - x(i);
    f2 = f(x);
    x(i) = x(i) + h;
    f3 = f(x);
    x(i) = x(i) - 2*h;
    f1 = f(x);
    val = f1 + f3;
    dif = val - 2*f2;
    ret = dif/h^2;
else % i ~= j
    x(i) = x(i) - 0.5*h; x(j) = x(j) - 0.5*h;
    hi = (x(i) + h) - x(i);
    hj = (x(j) + h) - x(j);
    f1 = f(x);
    x(i) = x(i) + hi;
    f2 = f(x);
    x(j) = x(j) + hj;
    f3 = f(x);
    x(i) = x(i) - hi;
    f4 = f(x);
    val = f1+f3;
    dif = val-(f2+f4);
    ret = dif/(hi*hj);
end
if nargout == 2
    digi = max(0, 15.6536 + log10(abs(dif/val)));
end
end
