% derivative of spherical hankel function of the second kind
function out = Dsbesselh2(l,x)
out = sbesselh2(l-1,x)-(l+1)./x.*sbesselh2(l,x);
end