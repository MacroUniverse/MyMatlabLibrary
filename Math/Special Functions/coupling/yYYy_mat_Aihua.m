% coupling matrix from Y_{l,m}^* Y_{l,m}
% coupling matrix from Y_{l,m}^* Y_{l,m}
function mat = yYYy_mat_Aihua(l, m, L_max, l1_max, l2_max)
[L, l1, l2] = AngBasis(L_max, l1_max, l2_max);
N = numel(L);
if any(issym(l,m,L_max,l1_max,l2_max))
    mat(N,N) = sym(0);
else
    mat = zeros(N,N);
end
for i = 1:N
    for j = 1:N
        mat(i,j) = yYYy(l1(i),l2(i),L(i),0,l,m,l1(j),l2(j),L(j),0);
    end
end
end
