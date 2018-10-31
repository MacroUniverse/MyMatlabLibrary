% Calculate spherical harmonics Y_{lm}
% same definition as Mathematica
% l,m must be a scalar
% size(Th) = size(Ph)
% Th and Ph can have any real values

function Y_lm = SphHarm(l,m,Th,Ph)
mark = mod(Th,2*pi) > pi;
Ph(mark) = Ph(mark) + pi;
Sign = sign(m);
m = abs(m);
P_lm = legendre(l,cos(Th(:)));
P_lm = P_lm(m+1,:);

% normalization factor
Y_lm = zeros(size(Th));
N_lm = sqrt((2*l+1)*factorial(l-m)./(4*pi*factorial(l+m)));
if Sign >= 0
    Y_lm(:) = N_lm * P_lm' .* exp(1i*m*Ph(:));
else
    Y_lm(:) = (-1)^m * N_lm * P_lm' .* exp(-1i*m*Ph(:));
end
end
