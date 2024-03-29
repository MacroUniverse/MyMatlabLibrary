% a revision of function eig
% A*V = V*D
% sort the eigen value matrix to descending order
% eigen vectors change order in the same way
% the first element of each eigen vector should be positive

function [V,D] = Eig(A, order)
if (~exist('order','var') || isempty(order))
    order = 'descend';
end
[V,D]=eig(A);
a=diag(D);
[a,order]=sort(a,order);
D=diag(a);
V=V(:,order);
for ii = 1:size(V,2)
    if V(1,ii) < 0
        V(:,ii) = -V(:,ii);
    end
end
end
