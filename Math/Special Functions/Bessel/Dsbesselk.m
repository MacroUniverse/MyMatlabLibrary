% derivative of modified spherical bessel function of the second kind
function out = Dsbesselk(l,x)
out = sbesselk(l-1,x)-(l+1)./x.*sbesselk(l,x);
end