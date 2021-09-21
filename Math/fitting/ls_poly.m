% fit polynomial to data points
% p(x) = c(1)x^order + c_2 x^(order-1) + ... c(order+1)
% numel(x) = numel(y)
function c = ls_poly(x, y, order)
Sx = zeros(1, 2*order+1);
Sx(1) = numel(x);
for n=1:2*order
    Sx(n+1) = sum(x.^n);
end

Sxy = zeros(order+1, 1);
for n=0:order
    Sxy(n+1) = sum(y .* x.^n);
end
Sxy = flip(Sxy);

A = zeros(order+1, order+1);
for i = 0:order
    for j = 0:order
        A(order-i+1,order-j+1) = Sx(i+j+1);
    end
end
c = A \ Sxy;
end
