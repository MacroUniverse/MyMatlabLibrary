% find fourier transform of an "fr" function along one direction
% 'k' (k >= 0) can be a vector
% 'scaled' is optional, default is 'false' (unscaled radial function)
% all vectors must be row vectors
% 'range' is optional, 'range(1) and range(2)' set the radial range for fft

function fk = fr_fft(fr, r, l, m, k, scaled, range)
if ~exist('scaled','var') || isempty(scaled), scaled = false; end
if ~exist('range','var') || isempty(range), range = nan; end
Nl = numel(l); Nm = numel(m); Nk = numel(k);
if ~isnan(range)
    ind1 = lookup(r, range(1))+1; ind2 = lookup(r, range(2));
    if (ind2 - ind1 < 20), error('less than 20 points in range!'); end
    r = r(ind1:ind2); Nr = numel(r);
else
    Nr = numel(r);
    ind1 = 1; ind2 = Nr;
end

if scaled, w = r; else, w = r.^2; end

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
            fk{jj,kk}(ii) = A_l(ii)*trapz(r,fr{jj,kk}(ind1:ind2).*j_l(ii,:).*w);
        end
    end
end

% scaled fk
if scaled
    fk = fr_mul(fk,k);
end
end
