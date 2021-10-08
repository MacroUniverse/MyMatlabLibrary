% Coulomb plane wave in cartesian coordinate
% Sign = 1 for outgoing spherical wave, Sign = -1 for incoming spherical
% wave
% 'numel(k) = 3'
% delta function normalization: delta(\vec k - \vec k'),
%     asymptotic plane wave with amplitude 1/(2*pi)^1.5

function Psi = coulomb_plane(k,X,Y,Z,ZZ,Sign)
if (ZZ < 0)
    error('ZZ (nuclear charge) must be positive!');
end
Sign = sign(Sign);
k0 = norm(k);
eta = -ZZ/k0;
k_dot_r = k(1)*X + k(2)*Y + k(3)*Z;
kr = k0*sqrt(X.^2+Y.^2+Z.^2);
C = 1/(2*pi)^1.5 * double(gamma(1+Sign*1i*vpa(eta))) * exp(-pi*eta*0.5);
Psi = C * exp(1i*k_dot_r) .* hypergeom(-Sign*1i*eta, 1, Sign*1i*kr - 1i*k_dot_r);
end
