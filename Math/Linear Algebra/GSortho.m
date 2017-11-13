% schmidt orthogonalization.
% V is column matrix
function V=GSortho(V)
Size = size(V);
V(:,1) = V(:,1)/norm(V(:,1));
for ii = 2:Size(2)
    for jj = 1:ii-1
        V(:,ii) = V(:,ii) - V(:,jj)' * V(:,ii)*V(:,jj);
    end
    V(:,ii) = V(:,ii)/norm(V(:,ii));
end
end