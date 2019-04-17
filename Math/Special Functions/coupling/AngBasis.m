% sort y_{l1,l2}^{L,M} basis for M = 0
% parity means y(-r1,-r2) symmetry
% checked with Aihua's Thesis Table 4.1
function [L, l1, l2, parity, exclude] = AngBasis(L_max, l1_max, l2_max)
k = 0;
l1s = zeros((L_max+1)*(l1_max+1)*(l2_max+1),1);
l2s = l1s; Ls = l1s;
for L = 0:L_max
    for l1 = 0:l1_max
        for l2 = 0:l2_max
            if abs(l1-l2) <= L && L <= l1 + l2
                k = k + 1;
                Ls(k) = L; l1s(k) = l1; l2s(k) = l2;
            end
        end
    end
end
L = Ls(1:k); l1 = l1s(1:k); l2 = l2s(1:k);
if nargout > 3
    parity = mod(l1 + l2,2);
end
if nargout > 4
exclude = mod(l1+l2-L,2);
end
end
