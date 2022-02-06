% table lookup
% given a ascending vector 'v', find ind so that "v(ind) <= x < v(ind+1)"
% input 'nobound' to turn off boundary checking
% if 'x < v(1)', ind = 0, if 'x > v(end)', ind = numel(v)

function ind = lookupL(v, x, nobound)
if ~exist('nobound','var') || isempty(nobound)
    nobound = false;
end
Nv = numel(v);
if ~nobound % with bound checking
    if x >= v(end) || x < v(1)
        error('x out of bound!');
    end
else
    if x >= v(end)
        ind = Nv; return;
    elseif x < v(1)
        ind = 0; return;
    end
end
ind = find(v <= x, 1, 'last'); % not optimized
end
