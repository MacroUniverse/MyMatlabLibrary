% derivative of regular coulomb wave function
% twice slower than 'coulomb1()'

function dFdr = dcoulomb1(l,k,r)
Z = -1; eta = Z/k;
C = 2^l*exp(-pi*eta*0.5)*abs(gammaC(l+1+1i*eta))/factorial(2*l+1);
rho = k*r;
expo = exp(-1i*rho);
dFdr = (l+1-1i*rho).*rho.^l.*expo.*hypergeom(l+1-1i*eta, 2*l+2, 2i*rho)....
       + (l+1-1i*eta)/(2*l+2)*2i*expo.*rho.^(l+1)....
       .*hypergeom(l+2-1i*eta, 2*l+3, 2i*rho);
dFdr = k*real(C*dFdr);
end
