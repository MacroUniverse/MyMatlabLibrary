% sum normalization

function A = sumnorm(A)
A = A/sum(abs(A(:)));
end