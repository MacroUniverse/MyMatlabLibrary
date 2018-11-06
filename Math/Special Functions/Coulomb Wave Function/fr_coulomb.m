% coulomb wave function in "fr" form (atomic units)
% 'Sign = 1' for incident plane wave, 'Sign = -1' for outgoing plane wave
% all vectors are row vectors
% https://en.wikipedia.org/wiki/Coulomb_wave_function
% http://mathworld.wolfram.com/CoulombWaveFunction.html

function fr = fr_coulomb(l,m,r,k,k_th,k_ph,Sign,scaled)
Sign = sign(Sign);
Z = -1; eta = Z/k;
Nl = numel(l); Nm = numel(m);
fr = cell(Nl,Nm);
% calculate scaled
for jj = 1:Nl
    ph_l = angle(gammaC(l(jj)+1+1i*eta));
    for kk = 1:Nm
        a_klm = sqrt(2/pi)*1i^(l(jj))/k*exp(Sign*1i*ph_l)....
                *conj(SphHarm(l(jj),m(kk),k_th,k_ph));
        fr{jj,kk} = a_klm*coulomb1(l(jj),k,r);
    end
end
% the case of unscaled
if nargin < 8 || ~scaled
    if r(1) > eps
        fr = fr_mul(fr,1./r);
    else
        R0 = exp(-pi*eta*0.5)*abs(gammaC(1+1i*eta));
        fr = fr_mul(fr,[0,1./r(2:end)]);
        
    end
end
end
