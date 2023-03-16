% Gauss-Lobatto points and weights
% only output n/2 positive x
function [x, w] = gauss_lobatto(n)
if mod(n, 2) ~= 0
    error('n must be even!');
end
Ninter = 3*n;
x = bisectionN(@(x)legendreP_der(n-1,x), [0,1], Ninter);
while numel(x) ~= n/2-1
    Ninter = Ninter * 2;
    x = bisectionN(@(x)legendreP_der(n-1,x), [0,1], Ninter);
end
x = [x, 1];
w = 2./(n*(n-1)*(legendreP(n-1, x)).^2);
end
