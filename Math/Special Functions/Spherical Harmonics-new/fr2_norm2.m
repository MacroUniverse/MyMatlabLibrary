% norm square of 3D spherical function
% see 'fr_dot()'
% if only 'fr' is passed, will assume dr = 1

function [out, each] = fr2_norm2(data, r, scaled)
if nargin > 1
    if nargin < 3, scaled = false; end
    [out,each] = fr2_dot(data,data,r,scaled);
else
    [out,each] = fr2_dot(data,data);
end
if ~isreal(out), error('output is complex, something is wrong!'); end
end
