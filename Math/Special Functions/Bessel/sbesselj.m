% spherical bessel function of the first kind
% x must be non-negative
% if(scaled), return sbesselj(n,x)*x
function out = sbesselj(n,x,scaled)
if any(x < 0), error('x must be non-negative!'); end
if ~exist('scaled','var') || isempty(scaled)
    scaled = false;
end
out = zeros(size(x));
mark = (x > 0);
if ~scaled
    out(mark) = sqrt(0.5*pi./x(mark)).*besselj(n+0.5,x(mark));
else
    out(mark) = sqrt(0.5*pi.*x(mark)).*besselj(n+0.5,x(mark));
end
mark = ~mark;
if n == 0 && ~scaled
    out(mark) = 1;
else
    out(mark) = 0;
end
end
