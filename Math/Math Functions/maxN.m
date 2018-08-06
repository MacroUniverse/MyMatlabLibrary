% Find the first N maximum
% this function is hilariously slower than "sort"

function [bestN, indN] = maxN(A,N)
NA = numel(A);
bestN = zeros(1,N);
indN = bestN;
for ii = 1:NA
    for jj = 1:N
        if A(ii) > bestN(jj)
            bestN(jj:end) = [A(ii), bestN(jj:end-1)];
            indN(jj:end) = [ii, indN(jj:end-1)];
            break;
        end
    end
end
end