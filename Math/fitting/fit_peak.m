% get precise position of any peak
% use polynomial fit then find local peak of polynomial
function [xp, yp] = fit_peak(x, y, order)
p = polyfit(x, y, order);
dp = polyder(p);
 xp = fzero(@(x)polyval(dp, x), [x(1), x(end)]);
 yp = polyval(p, xp);
 % figure; plot(x, y); hold on;
 % plot(x, polyval(p, x)); scatter(xp, yp);
end
