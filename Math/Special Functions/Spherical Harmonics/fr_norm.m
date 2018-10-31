% norm of 3D spherical function
% see 'fr_dot()'

function out = fr_norm(r, fr, scaled)
if nargin < 3, scaled = false; end
out = sqrt(fr_dot(r,fr,fr,scaled));
end
