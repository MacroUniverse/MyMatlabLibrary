% calculate momentum spectrum from coulomb wave function (atomic units)
% 'Sign = 1' projects onto incoming plane wave, 'Sign = -1' projects onto
%                                                     outgoing plane wave
% 'k' (k > 0) can be a vector
% 'scaled' is optional, default is 'false' (unscaled radial function)
% all vectors must be row vectors
% 'range' is optional, 'range(1) and range(2)' set the radial range for fft

function fk = fr_fft_coulomb(fr, r, l, m, k, Sign, scaled, range)
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
Nl = numel(l); Nm = numel(m); Nk = numel(k);
fk = cell(Nl,Nm);
F_l = zeros(Nk, Nr);
A_l = zeros(1, Nk);

% calculate scaled fk
for jj = 1:Nl
    for ii = 1:Nk
        ph_l = angle(gammaC(l(jj)+1+1i*Z/k(ii)));
        A_l(ii) = sqrt(2/pi)*1i^(-l(jj))*exp(-Sign*1i*ph_l);
        F_l(ii,:) = coulomb1_mex(l(jj),k(ii),r,Z,scaled);
    end
    for kk = 1:Nm
        if isempty(fr{jj,kk}), continue; end
        fk{jj,kk} = zeros(1,Nk);
        for ii = 1:Nk
            if scaled
                fk{jj,kk}(ii) = A_l(ii)*trapz(r,fr{jj,kk}(ind1:ind2).*F_l(ii,:));
            else
                fk{jj,kk}(ii) = A_l(ii)*trapz(r,fr{jj,kk}(ind1:ind2).*F_l(ii,:).*r);
            end
        end
    end
end

% unscaled fk
if ~scaled
    if k(1) < eps, error('k must be larger than 0!'); end
    fk = fr_mul(fk,1./k);
end
end
