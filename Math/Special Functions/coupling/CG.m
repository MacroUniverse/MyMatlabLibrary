% Clebsh-Gordan Coefficient
% support symbolic input
% all coeffs should be real, and the first column and row of each
% unitary matrix should be all positive
% input can be either numeric or symbolic

% function coeff = CG(l1,m1,l2,m2,L,M)
% coeff = clebschgordan(l1,m1,l2,m2,L,M);
% end

function coeff = CG(l1,m1,l2,m2,L,M)
% check legal input
if ~is_all_int(2*[l1,m2,l2,m2])
    error('input must be half integers!');
elseif ~is_all_int([m1+l1,m2+l2,M+L])
    error('integer/half integer error!');
elseif l1 < 0 || l2 < 0 || abs(m1) > l1 || abs(m2) > l2 || abs(M) > L
    error('illegal input!');
end

% basic selection rules
if L < abs(l1-l2) || L > l1 + l2...
   || m1 + m2 ~= M...
   || M < -L || M > L...
   || m1 < -l1 || m1 > l1...
   || m2 < -l2 || m2 > l2
    coeff = 0; return;
end

% advanced selection rules
if mod(l1+l2+L,2) == 1
    if m1 == 0 && m2 == 0 && M == 0 ...
        || l1 == l2 && m1 == m2 ...
        || l2 == L && m2 + M == 0 ...
        || l1 == L && m1 + M == 0
        coeff = 0; return;
    end
end

% check factorial accuracy
kmin = max([0,l2-m1-L,l1+m2-L]);
kmax = min([l1+l2-L,l1-m1,l2+m2]);
if ~any(issym(l1,m1,l2,m2,L,M))
    maxfac = max([L+l1-l2, L-l1+l2, l1+l2-L, l1+l2+L+1, L+M, L-M, l1-m1, l1+m1, l2-m2, l2+m2...
        kmax, l1+l2-L-kmin, l1-m1-kmin, l2+m2-kmin, L-l2+m1+kmax, L-l1-m2+kmax]);
    if maxfac > 21
        warning('calculating factorial of more than 21! will not be exact!');
    end
end

% calculate
C0 = sqrt((2*L+1)*factorial(L+l1-l2)*factorial(L-l1+l2)*factorial(l1+l2-L)/factorial(l1+l2+L+1)....
    *factorial(L+M)*factorial(L-M)*factorial(l1-m1)*factorial(l1+m1)*factorial(l2-m2)*factorial(l2+m2));

k = kmin:kmax;
terms = (-1).^k ./(factorial(k).*factorial(l1+l2-L-k).*factorial(l1-m1-k).*factorial(l2+m2-k).*...
    factorial(L-l2+m1+k).*factorial(L-l1-m2+k));
coeff = C0.*sum(terms);

% if CG_check_0(coeff)
%     warning('found a zero coefficient not excluded by selection rules!');
%     disp([l1, m1, l2, m2, L, M]);
% end
end
