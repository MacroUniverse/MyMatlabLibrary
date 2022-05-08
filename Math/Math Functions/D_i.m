% 数值偏偏导
% digi 是结果的有效数字
function [ret, digi] = D_i(f, i, x, h)
x(i) = x(i) - 0.5*h;
f1 = f(x);
h = (x(i) + h) - x(i);
x(i) = x(i) + h;
f2 = f(x);
dif = f2 - f1;
ret = dif/h;
if nargout == 2
    digi = max(0, 15.6536 + log10(abs(dif/f1)));
end
end
