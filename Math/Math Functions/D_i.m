% 数值偏微分
function ret = D_i(f, i, x, h)
x(i) = x(i) - h;
f1 = f(x);
x(i) = x(i) + 2*h;
f2 = f(x);
ret = (f2 - f1)/(2*h);
end
