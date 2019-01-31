% calculate matrix exponential using eigen vector
% only tested for hermitian matrix

function f = expA(A)
[V, D] = eig(A);
f = @(t) V*diag(exp(diag(D)*t))*V';
end
