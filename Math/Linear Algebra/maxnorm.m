% scale elements of A so that the max(abs(A(:))) is 1
function A = maxnorm(A)
A = A/max(abs(A(:)));
end