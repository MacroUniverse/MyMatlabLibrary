% spherical hankel function of the second kind
function out = sbesselh2(n,x)
out = sqrt(pi./(2*x)).*besselh(n+0.5,2,x);
end