% Coulomb function of the first kind F_l(eta, rho)
% verified with Mathematica
% l, eta are scalars, rho is vector

function ret = coulombF_sym(l, eta, rho)
syms L Eta Rho;
F = (-0.5i)^(L+1)*2^L*exp(-sym(pi)*Eta/2)....
    *abs(gamma(L+1+1i*Eta))/factorial(2*L+1)....
    *whittakerM(1i*Eta, L+1/2, 2i*Rho);

F = subs(F, L, vpa(l,17));
F = subs(F, Eta, vpa(eta,17));
ret = real(double(subs(F, Rho, vpa(rho,17))));
end
