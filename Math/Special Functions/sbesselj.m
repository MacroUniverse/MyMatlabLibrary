% spherical bessel function of the first kind
% make sure x is nonzero!
function out = sbesselj(n,x)
if any(x == 0), error('x cannot be 0!'); end
out = sqrt(pi./(2*x)).*besselj(n+0.5,x);
end
