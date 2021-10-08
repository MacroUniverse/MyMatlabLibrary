% coulomb wave function in "fr" form (atomic units)
% 'Sign = 1' for incident plane wave, 'Sign = -1' for outgoing plane wave
% all vectors are row vectors
% https://en.wikipedia.org/wiki/Coulomb_wave_function
% http://mathworld.wolfram.com/CoulombWaveFunction.html

function fr2 = fr2_coulomb(l,m,r,k,k_th,k_ph,Z,Sign)
if (Z < 0)
    error('Z (nuclear charge) must be positive!');
elseif isempty(m)
    m = zeros(size(l));
end
if (numel(l) ~= numel(m))
    error('l, m size must be equal');
end
l = round(l);

Sign = sign(Sign);
eta = -Z/k;
Nr = numel(r);
Npw = numel(l);
fr2 = zeros(Nr, Npw);

l_uniq = unique(l);
Fl_mat = zeros(Nr, numel(l_uniq));
for ii = 1:numel(l_uniq)
    Fl_mat(:,ii) = coulombF_sym(l_uniq(ii),eta,k.*r);
end

for ii = 1:Npw
    ph_l = angle(double(gamma(l(ii)+1+1i*vpa(eta,17))));
    a_klm = sqrt(2/pi)*1i^(l(ii))/k*exp(Sign*1i*ph_l)....
            *conj(SphHarm(l(ii),m(ii),k_th,k_ph));
    ind = find(l_uniq == l(ii), 1);
    % fr2{jj,kk} = a_klm*coulomb1_mex(l(jj),k,r,-Z,true);
    fr2(:, ii) = a_klm*Fl_mat(:, ind);
end
end
