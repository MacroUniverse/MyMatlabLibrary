% spherical bessel function of the second kind
function out = sbessely(n,x)
out = sqrt(pi./(2*x)).*bessely(n+0.5,x);
end