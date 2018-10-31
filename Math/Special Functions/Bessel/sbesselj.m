% spherical bessel function of the first kind
% x must be non-negative
function out = sbesselj(n,x)
if any(x < 0), error('x must be non-negative!'); end
out = zeros(size(x));
mark = (x > 0);
out(mark) = sqrt(0.5*pi./x(mark)).*besselj(n+0.5,x(mark));
mark = ~mark;
if n == 0
    out(mark) = 1;
else
    out(mark) = 0;
end
end
