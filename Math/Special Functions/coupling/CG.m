% Clebsh-Gordan Coefficient
% support symbolic input
% all coeffs should be real, and the first column and row of each
% unitary matrix should be all positive
% input can be either numeric or symbolic

function coeff = CG(l1,m1,l2,m2,L,M)
% check legal input
temp = [l1,m2,l2,m2]*2;
if ~isequal(round(temp), temp)
    error('input must be half integers!');
end

if l1 < 0 || l2 < 0 || abs(m1) > l1 || abs(m2) > l2 || abs(M) > L
    error('illegal input!');
end

% check 0 coeffs
if L < abs(l1-l2) || L > l1 + l2
    coeff = 0; return;
end

if m1 + m2 ~= M
    coeff = 0; return;
end

% calculate
C0 = sqrt((2*L+1)*factorial(L+l1-l2)*factorial(L-l1+l2)*factorial(l1+l2-L)/factorial(l1+l2+L+1)....
    *factorial(L+M)*factorial(L-M)*factorial(l1-m1)*factorial(l1+m1)*factorial(l2-m2)*factorial(l2+m2));

k = max([0,l2-m1-L,l1+m2-L]):min([l1+l2-L,l1-m1,l2+m2]);
terms = (-1).^k ./(factorial(k).*factorial(l1+l2-L-k).*factorial(l1-m1-k).*factorial(l2+m2-k).*...
    factorial(L-l2+m1+k).*factorial(L-l1-m2+k));
coeff = C0.*sum(terms);
end
