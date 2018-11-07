% find fourier transform of an "fr" function along one direction
% 'k' (k >= 0) can be a vector
% 'scaled' is optional, default is 'false' (unscaled radial function)
% all vectors must be row vectors

function fk = fr_fft(fr, r, l, m, k, scaled)
if ~exist('scaled','var') || isempty(scaled), scaled = false; end
if scaled, w = r; else, w = r.^2; end
Nl = numel(l); Nm = numel(m); Nr = numel(r); Nk = numel(k);
fk = cell(Nl,Nm);
j_l = zeros(Nk, Nr);
A_l = zeros(1, Nk);

% calculate unscaled fk
for jj = 1:Nl
    for ii = 1:Nk
        A_l(ii) = sqrt(2/pi)*1i^(-l(jj));
        j_l(ii,:) = sbesselj(l(jj),k(ii)*r);
    end
    for kk = 1:Nm
        if isempty(fr{jj,kk}), continue; end
        fk{jj,kk} = zeros(1,Nk);
        for ii = 1:Nk
            fk{jj,kk}(ii) = A_l(ii)*trapz(r,fr{jj,kk}.*j_l(ii,:).*w);
        end
    end
end

% scaled fk
if scaled
    fk = fr_mul(fk,k);
end
end
