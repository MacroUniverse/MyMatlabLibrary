% derivative of spherical bessel function of the first kind
% if(scaled), return D[x*sbesselj(n,x)]
function out = Dsbesselj(l,x,scaled)
if ~exist('scaled','var') || isempty(scaled)
    scaled = false;
end
if ~scaled
    out = sbesselj(l-1,x)-(l+1)./x.*sbesselj(l,x);
else
    out = x.*sbesselj(l-1,x)-l.*sbesselj(l,x);
end
end
