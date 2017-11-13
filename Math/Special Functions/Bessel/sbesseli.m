% modified spherical bessel function of the first kind
function out = sbesseli(n,x)
out = sqrt(pi./(2*x)).*besseli(n+0.5,x);
end