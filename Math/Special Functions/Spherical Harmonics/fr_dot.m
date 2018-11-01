% calculate inner product of two "fr" functions
% use 'trapz()' to integrate "conj(fr1)*fr2*r^r_pow"
% 'r_pow' default is 2, for unscaled "fr"
% for scaled "fr", use 'scaled = true', default is 'false'
% if only input 'fr1', 'fr2', will use 'dr = 1; scaled = true;'
% 'each' is an Nl-by-Nm matrix, the result of each {l,m} term

function [out, each] = fr_dot(fr1, fr2, r, scaled)

if nargin < 3
    [Nl, Nm] = size(fr1);
    each = zeros(size(fr1));
    for ii = 1:Nl
    for jj = 1:Nm
        if ~isempty(fr1{ii,jj})
            each(ii,jj) = sum(conj(fr1{ii,jj}).*fr2{ii,jj});
        end
    end
    end
    out = sum(each(:)); return;
end

if nargin < 4, scaled = false; end
[Nl, Nm] = size(fr1);
each = zeros(size(fr1));
if ~scaled
    w = r.^2;
    for ii = 1:Nl
    for jj = 1:Nm
        if ~isempty(fr1{ii,jj})
            each(ii,jj) = trapz(r, conj(fr1{ii,jj}).*fr2{ii,jj}.*w);
        end
    end
    end
else % scaled
    for ii = 1:Nl
    for jj = 1:Nm
        if ~isempty(fr1{ii,jj})
            each(ii,jj) = trapz(r, conj(fr1{ii,jj}).*fr2{ii,jj});
        end
    end
    end
end
out = sum(each(:));
end

