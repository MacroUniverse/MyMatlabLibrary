% evaluate 1F1 using asymptotic series

function y = hg1F1_as(a, b, x, N)
digits(16);
a = vpa(a); b = vpa(b); x = vpa(x);
r = vpa(zeros(1,N+1));
% r(ii+1) is coef of (1/z)^ii
c = gamma(b)*(-x)^(-a)/gamma(b-a);
d = exp(x)*x^(a-b)*gamma(b)/gamma(a);
r(1) = c + d;
for ii = 1:N
    c = -c*(a+ii-1)*(a-b+1+ii-1)/ii;
    d = d*(b-a+ii-1)*(1-a+ii-1)/ii;
    r(ii+1) = c + d;
end
y(N+1) = r(N+1);
xInv = 1/x;
for ii = N:-1:1
    y(ii) = y(ii+1)*xInv + r(ii);
end
y = y(1);
end
