% derivative of modified spherical bessel function of the second kind
function out = Dsbesseli(l,x)
out = sbesseli(l-1,x)-(l+1)./x.*sbesseli(l,x);
end