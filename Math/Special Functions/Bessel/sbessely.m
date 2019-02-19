% spherical bessel function of the second kind
% x must be non-negative
% if(scaled), return sbessely(n,x)*x
function out = sbessely(n,x,scaled)
if any(x <= 0), error('x must be positive!'); end
if ~exist('scaled','var') || isempty(scaled)
    scaled = false;
end
if ~scaled
    out = sqrt(0.5*pi./x).*bessely(n+0.5,x);
else
    out = sqrt(0.5*pi.*x).*bessely(n+0.5,x);
end
end
