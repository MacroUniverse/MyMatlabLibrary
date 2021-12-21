% get precise position of any peak
% use polynomial fit then find local peak of polynomial
function [xp, yp, p] = fit_peak(x, y, order)
p = polyfit(x, y, order);
dp = polyder(p);
f = @(x)polyval(dp, x);
if (f(x(1)) * f(x(end)) >= 0)
    figure; plot(x, y); hold on;
end
xp = fzero(f, [x(1), x(end)]);
yp = polyval(p, xp);
% figure; plot(x, y); hold on;
% plot(x, polyval(p, x)); scatter(xp, yp);
end
