% match a $fun(x)$ to $A*sin(kx + \phi)$ at the point 'x0'
% v(1) = f(x), v(2) = f'(x)
function [phi, A] = match_sin(v, k, x0)
s = sin(k*x0); c = cos(k*x0);
temp = [s, c; k*c, -k*s]\v(:);
phi = atan2(temp(2),temp(1));
A = sqrt(temp(1)^2+temp(2)^2);
end
