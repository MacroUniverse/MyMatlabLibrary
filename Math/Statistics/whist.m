% weighted histogram
% grid(ii) is the center of the ii-th bin
% grid must be equally spaced.

function hist = whist(x, w, grid)
Nbin = numel(grid);
Nx = numel(x);
half_bin = (grid(end)-grid(1))/(numel(grid)-1)/2;
hist = zeros(1,Nbin);
for ii = 1:Nx
    if isnan(x(ii)) || x(ii) < grid(1) - half_bin || isnan(w(ii))
        continue;
    end
    for jj = 1:Nbin
        if x(ii) < grid(jj) + half_bin
            hist(jj) = hist(jj) + w(ii);
            break;
        end
    end
end
end
