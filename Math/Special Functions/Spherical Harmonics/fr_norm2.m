% norm square of 3D spherical function
% see 'fr_dot()'

function out = fr_norm2(r, fr, scaled)
if nargin < 3, scaled = false; end
out = fr_dot(r,fr,fr,scaled);
end
