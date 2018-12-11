% table lookup
% given a ascending vector 'v', find ind so that "v(ind) <= x < v(ind+1)"
% 'x' can also be a matrix, then 'ind' has the same size
% input 'nobound' to turn off boundary checking
% if 'x < v(1)', ind = 0, if 'x > v(end)', ind = numel(v)

function ind = lookupL(v, x, nobound)
if ~exist('nobound','var') || isempty(nobound)
    nobound = false;
end
Nv = numel(v); Nx = numel(x);
ind = zeros(size(x));

if ~nobound % with bound checking
    temp = x(:) > v(end) || x(:) < v(1);
    if any(temp)
        error(['x(', find(temp), ') out of range!']);
    end
    for ii = 1:Nx
        ind(ii) = find(v <= x(ii), 1, 'last');
    end
else
    for ii = 1:Nx
        if x(ii) > v(end)
            ind(ii) = Nv; continue;
        elseif x(ii) <= v(1)
            ind(ii) = 0; continue;
        end
        ind(ii) = find(v <= x(ii), 1, 'last');
    end
end
end
