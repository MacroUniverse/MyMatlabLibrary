% spherical harmonics with m = 0
% same definition as Mathematica
% l,m must be a scalar
% Th can have any real values

function Y_lm = SphHarm0(l,Th)
p = legendre(l,cos(Th(:)));
p = p(1,:);
Y_lm = zeros(size(Th));
Y_lm(:) = sqrt((2*l+1)/(4*pi)) * p;
end
