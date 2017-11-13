% spherical hankel function of the first kind
function out = sbesselh1(n,x)
out = sqrt(pi./(2*x)).*besselh(n+0.5,x);
end