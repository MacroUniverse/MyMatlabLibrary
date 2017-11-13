% modified spherical bessel function of the second kind
function out = sbesselk(n,x)
out = sqrt(pi./(2*x)).*besselk(n+0.5,x);
end