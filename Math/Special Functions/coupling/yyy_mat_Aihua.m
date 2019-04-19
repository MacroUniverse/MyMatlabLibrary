% coupling matrix from Y_{l,m}^* Y_{l,m}
% L(i),M(i),l1(i),l2(i) are for the i-th basis
function mat = yyy_mat_Aihua(l, L, M, l1, l2)
Ndim = numel(L);
if any(issym(l,L,M,l1,l2))
    mat(Ndim,Ndim) = sym(0);
else
    mat = zeros(Ndim,Ndim);
end
for i = 1:Ndim
    for j = 1:Ndim
        mat(i,j) = yyy_Aihua(l1(i),l2(i),L(i),M(i),l,l1(j),l2(j),L(j),M(j));
    end
end
end
