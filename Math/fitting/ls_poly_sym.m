% fit polynomial to data points
% p(x) = c(1)x^order + c_2 x^(order-1) + ... c(order+1)
% numel(x) = numel(y)
function c = ls_poly_sym(x, y, order)
digits(32);
x = vpa(x); y = vpa(y);
Sx = vpa(zeros(1, 2*order+1));
Sx(1) = vpa(numel(x));
for n=1:2*order
    Sx(n+1) = sum(x.^n);
end

Sxy = vpa(zeros(order+1, 1));
for n=0:order
    Sxy(n+1) = sum(y .* x.^n);
end
Sxy = flip(Sxy);

A = vpa(zeros(order+1, order+1));
for i = 0:order
    for j = 0:order
        A(order-i+1,order-j+1) = Sx(i+j+1);
    end
end
c = A \ Sxy;
end
