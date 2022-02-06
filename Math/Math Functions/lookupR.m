% table lookup
% input 'nobound' to turn off boundary checking
% given a ascending vector 'v', find ind so that "v(ind-1) < x <= v(ind)"
% if 'x < v(1)', ind = 1, if 'x > v(end)', ind = numel(v)+1

function ind = lookupR(v, x, nobound)
if ~exist('nobound','var') || isempty(nobound)
    nobound = false;
end
Nv = numel(v);
if ~nobound % with bound checking
    if x > v(end) || x < v(1)
        error('x out of bound!');
    end
else
    if x > v(end)
        ind = Nv+1; return;
    elseif x < v(1)
        ind = 1; return;
    end
end
ind = find(v >= x, 1); % not optimized
end
