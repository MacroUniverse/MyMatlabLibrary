% a revision of function eig
% sort the eigen value matrix to descending order
% eigen vectors change order in the same way
% the first element of each eigen vector should be positive

function [V,D]=Eig(A)

[V,D]=eig(A);
a=diag(D);
[a,order]=sort(a,'descend');
D=diag(a);
V=V(:,order);
for ii = 1:size(V,2)
    V(:,ii) = V(:,ii)*sign(V(1,ii));
end
end