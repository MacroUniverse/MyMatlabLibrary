% create a unitary matrix of CG coefficients.
% support symbolic input
% checked with wikipedia "Table of Clebsch�Gordan coefficients"
% U(i,j) is <l1,m1(i),l2,M-m1(i)|L(j),M>

function [U, m1, L] = CGtable(l1, l2, M)
if l1 < 0 || l2 < 0 || abs(M) > l1 + l2
    error('illegal input!');
end
if abs(M) > abs(l1-l2)
    Ndim = l1+l2-abs(M)+1;
else
    Ndim = 2*min(l1,l2)+1;
end
if M >= l1 - l2
    m1max = l1;
else
    m1max = l2+M;
end
m1 = m1max:-1:(m1max-Ndim+1);
m2 = M - m1;
L = (l1+l2):-1:(l1+l2-Ndim+1);
for i = Ndim:-1:1
    for j = Ndim:-1:1
        U(i,j) = CG(l1,m1(i),l2,m2(i),L(j),M);
    end
end
end
