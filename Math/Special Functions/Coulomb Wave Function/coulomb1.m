% coulomb function of the first kind
% see PhysWiki for detail
% https://en.wikipedia.org/wiki/Coulomb_wave_function
% http://mathworld.wolfram.com/CoulombWaveFunction.html
% 'l','k' are scalars, 'r' is a vector

function F = coulomb1(l,k,r)
Z = -1; eta = Z/k;
rho = k*r;
C = 2^l*exp(-pi*eta*0.5)*abs(gammaC(l+1+1i*eta))/factorial(2*l+1);
F = C*rho.^(l+1).*exp(-1i*rho).*hypergeom(l+1-1i*eta,2*l+2,2i*rho);
F = real(F);
end
