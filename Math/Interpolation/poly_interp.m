% polynomial interpolation
% y = polyval(p, x) = p(0)x^n + p(1)x^{n-1} + ...
function p = poly_interp(x0, y0)
X = vander(x0);
p = linsolve(X, y0(:));
p = p.';
end
