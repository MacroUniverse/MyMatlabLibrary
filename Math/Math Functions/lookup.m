% table lookup
% slow implementation
% given a ascending vector 'v', find ind so that "v(ind) <= x < v(ind+1)"
% 'x' can also be a matrix, then 'ind' has the same size
% input 'nobound' to turn off boundary checking

function ind = lookup(v, x, nobound)
    Nv = numel(v); Nx = numel(x);
    ind = zeros(size(x));
    if nargin > 2 && nobound % with bound checking
        for ii = 1:Nx
            if x(ii) >= v(end) || x(ii) < v(1)
                if x(ii) == v(end), ind(ii) = Nv; continue; end
                error(['x(', num2str(ii), ') out of range!']);
            end
            ind(ii) = find(v > x(ii), 1) - 1;
        end
    else
        for ii = 1:Nx
            if x(ii) >= v(end)
                ind(ii) = Nv; continue;
            elseif x(ii) <= v(1)
                ind(ii) = 1; continue;
            end
            ind(ii) = find(v > x(ii), 1) - 1;
        end
    end
end
