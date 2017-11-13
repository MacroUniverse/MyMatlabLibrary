% Lanczos Algorithm to find tridiagonal matrix
% K <= rank(H)

function [M,V,alpha, beta] = lanczos(H,V1,K)
V1 = V1/norm(V1);
V = zeros(numel(V1),K); V(:,1) = V1; M = zeros(K,K);
alpha = zeros(1,K); beta = zeros(1,K-1);
alpha(1) = V1' * H * V1;
temp = H * V1 - alpha(1) * V1;
beta(1) = norm(temp);
V(:,2) = temp/beta(1);
M(1,1) = alpha(1); M(1,2) = beta(1); M(2,1) = beta(1);
for ii = 2:K-1
    Vii = V(:,ii);
    alpha(ii) = Vii' * H * Vii;
    temp = H*Vii - alpha(ii) * Vii - beta(ii-1) * V(:,ii-1);
    beta(ii) = norm(temp);
    V(:,ii+1) = temp/beta(ii);
    M(ii,ii) = alpha(ii); M(ii+1,ii) = beta(ii); M(ii,ii+1) = beta(ii);
end
alpha(K) = V(:,K)' * H * V(:,K);
M(K,K) = alpha(K);
end