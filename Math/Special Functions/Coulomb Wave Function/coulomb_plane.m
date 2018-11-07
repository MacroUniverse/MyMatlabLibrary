% coulomb plane wave in cartesian coordinate
% 'numel(k) = 3'
% delta(\vec k - \vec k')

function Psi = coulomb_plane(k,X,Y,Z,Sign)
Sign = sign(Sign);
k0 = norm(k);
ZZ = -1; eta = ZZ/k0;
k_dot_r = k(1)*X + k(2)*Y + k(3)*Z;
kr = k0*sqrt(X.^2+Y.^2+Z.^2);
C = 1/(2*pi)^1.5 * gammaC(1+Sign*1i*eta) * exp(-pi*eta*0.5);
Psi = C * exp(1i*k_dot_r).*hypergeom(-Sign*1i*eta, 1, Sign*1i*kr - 1i*k_dot_r);
end
