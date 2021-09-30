% 最小二乘法拟合一元实函数，(x0,y0) 是数据点
% p0 是函数初始参数， double 矢量
% 输出最优的 p 以及（局部）最小方差 s
% 使方差 sum(abs(fun(x0, p) - y0).^2) 最小
% p_err 是每个 p(i) 的绝对误差

function [p, s] = curveFit(x0, y0, fun, p0, p_err)
% Nelder-Mead 求方差最小值点
s2 = @(p) sum((fun(x0, p) - y0).^2);
p = NelderMead(s2, p0, p_err);
s = fun(x0, p);
end
