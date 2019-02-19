% derivative of spherical bessel function of the second kind
% if(scaled), return D[x*sbessely(n,x)]
function out = Dsbessely(l,x,scaled)
if ~exist('scaled','var') || isempty(scaled)
    scaled = false;
end
if ~scaled
    out = sbessely(l-1,x)-(l+1)./x.*sbessely(l,x);
else
    out = sbessely(l-1,x).*x-l.*sbessely(l,x);
end
end
