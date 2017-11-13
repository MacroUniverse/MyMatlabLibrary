% derivative of spherical bessel function of the second kind
function out = Dsbessely(l,x)
out = sbessely(l-1,x)-(l+1)./x.*sbessely(l,x);
end