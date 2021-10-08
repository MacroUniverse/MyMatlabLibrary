% coulomb wave function in "fr" form (atomic units)
% 'Sign = 1' for incident plane wave, 'Sign = -1' for outgoing plane wave
% all vectors are row vectors
% https://en.wikipedia.org/wiki/Coulomb_wave_function
% http://mathworld.wolfram.com/CoulombWaveFunction.html

function fr = fr_coulomb(l,m,r,k,k_th,k_ph,Z,Sign,scaled)
if (Z >= 0)
    error('Z (nuclear charge) must be negative!');
end
Sign = sign(Sign);
eta = Z/k;
Nl = numel(l); Nm = numel(m);
fr = cell(Nl,Nm);
% either scaled or unscaled
for jj = 1:Nl
    ph_l = angle(gammaC(l(jj)+1+1i*eta));
    for kk = 1:Nm
        if abs(m(kk)) > l(jj)
            continue;
        end
        a_klm = sqrt(2/pi)*1i^(l(jj))/k*exp(Sign*1i*ph_l)....
                *conj(SphHarm(l(jj),m(kk),k_th,k_ph));
        fr{jj,kk} = a_klm*coulomb1_mex(l(jj),k,r,Z,scaled);
        % coulomb1_mex will not work for Z ~= -1
    end
end
end
