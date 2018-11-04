% coulomb wave function in "fr" form
% https://en.wikipedia.org/wiki/Coulomb_wave_function
% http://mathworld.wolfram.com/CoulombWaveFunction.html
% boundary condition: incident wave is normalized plane wave

function fr = fr_coulomb(l,m,r,k,k_th,k_ph,scaled)
Z = -1;
Nl = numel(l); Nm = numel(m);
fr = cell(Nl,Nm);
% calculate scaled
for jj = 1:Nl
    ph_l = angle(gammaC(l(jj)+1+1i*Z/k));
    for kk = 1:Nm
        a_klm = sqrt(2/pi)*1i^(l(jj))/k*exp(1i*ph_l)....
                *conj(SphHarm(l(jj),m(kk),k_th,k_ph));
        fr{jj,kk} = a_klm*coulomb1(l(jj),k,r);
    end
end
% the case of unscaled
if nargin < 7 || ~scaled
    fr = fr_mul(fr,1./r);
end
end
