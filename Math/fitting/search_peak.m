% find peak of 1d discrete function
% use fminsearch() and interp1()

function [xp, yp, fun] = search_peak(x, y, x_start)
fun = @(xq) -1*interp1(x, y, xq, 'spline');
opt = optimset('TolX', 1e-12);
[xp, yp] = fminsearch(fun, x_start, opt);
yp = -yp;
fun = @(xq) interp1(x, y, xq, 'spline');
end
