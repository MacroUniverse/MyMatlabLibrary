% fit polynomial to data points with Nelder-Mead optimization
% p(x) = c(1)x^order + c_2 x^(order-1) + ... c(order+1)
% numel(x) = numel(y)
function [c, s] = ls_poly_nelder_sym(x0, y0, c0, c_err)
fun = @(x, c) polyval_sym(c, x);
[c, s] = curveFit_sym(x0, y0, fun, c0, c_err);
end
