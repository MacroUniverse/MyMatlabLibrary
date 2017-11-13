% derivative of spherical bessel function of the first kind
function out = Dsbesselj(l,x)
out = sbesselj(l-1,x)-(l+1)./x.*sbesselj(l,x);
end