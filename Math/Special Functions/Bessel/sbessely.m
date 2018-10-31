% spherical bessel function of the second kind
% x must be non-negative
function out = sbessely(n,x)
if any(x <= 0), error('x must be positive!'); end
out = sqrt(0.5*pi./x).*bessely(n+0.5,x);
end
