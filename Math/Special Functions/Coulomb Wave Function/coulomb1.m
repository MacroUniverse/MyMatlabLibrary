% coulomb function of the first kind
% 'scaled' is 'true' by default, asymptotic form is 'sin(kr + ...)'
% 'l','k' are scalars, 'r' is a vector
% "r >= 0" and "k > 0.0023" is required.
% TODO: fix this! At least support k = 0.
% TODO: not sure if k < 0 works.
% see PhysWiki for detail
% https://en.wikipedia.org/wiki/Coulomb_wave_function
% http://mathworld.wolfram.com/CoulombWaveFunction.html

function F = coulomb1(l,k,r,Z,scaled)
if ~exist('scaled','var') || isempty(scaled), scaled = true; end
if ~exist('Z','var') || isempty(Z), Z = -1; end
if k < 0.0023, error('k must >= 0.0023 !'); end
if any(r<0), error('r must >= 0 !'); end
eta = Z/k;
rho = k*r;

% symbolic constant
C = 2^l*exp(-pi*eta*0.5)*abs(gammaC(l+1+1i*eta))/factorial(2*l+1);
if scaled
    % calculate scaled
    F = C*rho.^(l+1).*exp(-1i*rho).*hypergeom(l+1-1i*eta,2*l+2,2i*rho);
else
    % calculate scaled
    F = C*k*rho.^l.*exp(-1i*rho).*hypergeom(l+1-1i*eta,2*l+2,2i*rho);
end


end
