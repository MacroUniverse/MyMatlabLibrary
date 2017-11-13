% Legendre Polynomial Pn Coefficient
% p(end) is the constant term

function p = LegendreP(n)
N = floor(n/2);
p = zeros(1,n+1);
for m = 0:N
    p(2*m+1) = (-1)^m*nchoosek(n,m)*nchoosek(2*(n-m),n);
end
p = p/2^n;
end