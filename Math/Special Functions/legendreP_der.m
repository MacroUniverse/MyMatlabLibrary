% derivative of Legendre polynomial
% https://wuli.wiki/changed/Legen.html#Legen_eq6
function y = legendreP_der(n, x)
y = (n+1) * (x.*legendreP(n,x) - legendreP(n+1,x)) ...
    ./ (1 - x.^2);
end
