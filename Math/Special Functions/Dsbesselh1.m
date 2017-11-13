% derivative of spherical hankel function of the first kind
function out = Dsbesselh1(l,x)
out = sbesselh1(l-1,x)-(l+1)./x.*sbesselh1(l,x);
end