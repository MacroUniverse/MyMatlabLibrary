% calculate momentum spectrum from coulomb wave function (atomic units)
% 'Sign = 1' projects onto incoming plane wave, 'Sign = -1' projects onto
%                                                     outgoing plane wave
% 'k' (k > 0) can be a vector
% 'scaled' is optional, default is 'false' (unscaled radial function)
% all vectors must be row vectors
% 'range' is optional, 'range(1) and range(2)' set the radial range for fft

function data_k = fr2_fft_coulomb(data, r, l, m, k, Sign, scaled, range)
if ~exist('scaled','var') || isempty(scaled), scaled = false; end
if ~exist('range','var') || isempty(range), range = nan; end
if ~isnan(range)
    ind1 = lookupR(r, range(1), true); ind2 = lookupL(r, range(2), true);
    if (ind2 - ind1 < 20), error('less than 20 points in range!'); end
    r = r(ind1:ind2); Nr = numel(r);
else
    Nr = numel(r);
    ind1 = 1; ind2 = Nr;
end

Z = -1; % change q1*q2 for hydrogen
Npw = numel(l); Nk = numel(k);
data_k = zeros(Nk, Npw);
lmin = min(l); lmax = max(l);

% calculate scaled fk
for ik = 1:Nk
    F_l = cell(1, lmax-lmin+1);
    for pw = 1:Npw
        ph_l = angle(gamma(sym(l(pw)+1+1i*Z/k(ik))));
        A_l = sqrt(2/pi)*1i^(-l(pw))*exp(-Sign*1i*ph_l);
        ind = l(pw)-lmin+1;
        if isempty(F_l{ind})
            F_l{ind} = coulomb1_mex(l(pw),k(ik),r,Z,scaled);
        end
        if scaled
            data_k(ik, pw) = A_l*trapz(r,data(ind1:ind2,pw).'.*F_l{ind});
        else
            data_k(ik, pw) = A_l*trapz(r,data(ind1:ind2,pw).'.*F_l{ind}.*r);
        end
    end
end

% unscaled fk
if ~scaled
    if k(1) < eps, error('k must be larger than 0!'); end
    data_k = data_k ./ k(:);
end
end
