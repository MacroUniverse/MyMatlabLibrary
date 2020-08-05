% calculate a cubic spline function by positions and derivatives of two
% points
function [c0, c1, c2, c3] = cubic_spline_2p(x1, y1, der1, x2, y2, der2)
A = [
    1 x1 x1^2 x1^3;
    1 x2 x2^2 x2^3;
    0 1  2*x1 3*x1^2;
    0 1  2*x2 3*x2^2
    ];
b = [y1; y2; der1; der2];
tmp = A \ b;
c0 = tmp(1); c1 = tmp(2); c2 = tmp(3); c3 = tmp(4);
end
