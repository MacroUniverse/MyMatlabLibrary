% find 3D fourier transform of an "fr" function
% the result will also be in the form of "fr" function
% 'k' (k >= 0) is a vector, the radial grid for 'fk'
% 'scaled' is optional, default is 'false' (unscaled radial function)
% all vectors must be row vectors
% 'range' is optional, 'range(1) and range(2)' set the radial range for fft

function data_k = fr2_fft(data, r, l, m, k, scaled, range)
if ~exist('scaled','var') || isempty(scaled), scaled = false; end
if ~exist('range','var') || isempty(range), range = nan; end
Npw = size(data, 2); Nr = numel(r); Nk = numel(k);
if numel(l) ~= Npw || numel(m) ~= Npw || size(data, 1) ~= Nr
    error('illegal size');
end
if ~isnan(range)
    ind1 = lookupR(r, range(1), true); ind2 = lookupL(r, range(2), true);
    if (ind2 - ind1 < 20), error('less than 20 points in range!'); end
    r = r(ind1:ind2);
else
    ind1 = 1; ind2 = Nr;
end

if scaled, w = r; else, w = r.^2; end

data_k = zeros(Nk, Npw);
lmin = min(l); lmax = max(l);

% calculate unscaled fk
for ik = 1:Nk
    j_l = cell(1, lmax-lmin+1);
    for pw = 1:Npw
        A_l = sqrt(2/pi)*1i^(-l(pw));
        ind = l(pw)-lmin+1;
        if isempty(j_l{ind})
            j_l{ind} = sbesselj(l(pw),k(ik)*r);
        end
        data_k(ik, pw) = A_l * trapz(r, data(ind1:ind2, pw).'.*j_l{ind}.*w);
    end
end

% scaled data_k
if scaled
    data_k = data_k .* k(:);
end
end
