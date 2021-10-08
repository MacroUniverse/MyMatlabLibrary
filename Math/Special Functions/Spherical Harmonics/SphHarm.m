% Calculate spherical harmonics Y_{lm}
% same definition as Mathematica
% l,m must be a scalar
% size(Th) = size(Ph)
% Th and Ph can have any real values

function Y_lm = SphHarm(l,m,Th,Ph)
mark = mod(Th,2*pi) > pi;
Ph(mark) = Ph(mark) + pi;
if m > l, error('m > l'); end
Sign = sign(m);
m = abs(m);
P_lm = legendre(l,cos(Th(:)));
P_lm = P_lm(m+1,:);
if (~all(isfinite(P_lm)))
    error('l too large');
end

% normalization factor
Y_lm = zeros(size(Th));
fac_d_fac = prod(l-m+1:l+m);
if (isinf(fac_d_fac))
    error('overflow!');
end
N_lm = sqrt((2*l+1)./(4*pi*fac_d_fac));
if Sign >= 0
    Y_lm(:) = N_lm * P_lm' .* exp(1i*m*Ph(:));
else
    Y_lm(:) = (-1)^m * N_lm * P_lm' .* exp(-1i*m*Ph(:));
end
end
