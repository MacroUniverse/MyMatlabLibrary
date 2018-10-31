% find fourier transform of an "fr" function along one direction
% 'k' can be a vector
% 'scaled' is 'true' for scaled 'fr', default is 'false'
% '(th,ph)' is direction of k, must be scalars

function spec = fr_fft(r, fr, l, m, k, th, ph, scaled)
if nargin < 8, scaled = false; end
if scaled, w = r; else, w = r.^2; end
Nl = numel(l); Nm = numel(m); Nk = numel(k);
spec = zeros(1,Nk);
for jj = 1:Nl
for kk = 1:Nm
    if isempty(fr{jj,kk}), continue; end
    const = sqrt(2/pi)*1i^(-l(jj))*SphHarm(l(jj),m(kk),th,ph);
    for ii = 1:Nk
        if k(ii) < 0, const1 = const*(-1)^l(jj); else, const1 = const; end
        spec(ii) = spec(ii) + const1 *....
        trapz(r, fr{jj,kk}.*sbesselj(l(jj), abs(k(ii))*r).*w);
    end
end
end
end
