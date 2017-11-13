% l,m must be a scalar
% size(theta) = size(phi)

function Y_lm = SphHarm(l,m,theta,phi)
Sign = sign(m);
m = abs(m);
P_lm = legendre(l,cos(theta(:)));
P_lm = P_lm(m+1,:);

% normalization factor
Y_lm = zeros(size(theta));
if Sign >= 0
    N_lm = sqrt((2*l+1)*factorial(l-m)./(4*pi*factorial(l+m)));
    Y_lm(:) = N_lm*P_lm'.*exp(1i*m*phi(:));
else
    N_lm = (-1)^m*sqrt((2*l+1)*factorial(l-m)./(4*pi*factorial(l+m)));
    Y_lm(:) = N_lm*P_lm'.*exp(-1i*m*phi(:));
end
end
