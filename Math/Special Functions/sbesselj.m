% spherical bessel function of the first kind
function out = sbesselj(n,x)
out = sqrt(pi./(2*x)).*besselj(n+0.5,x);
end