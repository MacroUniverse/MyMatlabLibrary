% calculate inner product of two "fr" functions
% use 'trapz()' to integrate "conj(fr1)*fr2*r^r_pow"
% 'r_pow' default is 2, for unscaled "fr"
% for scaled "fr", use 'scaled = true', default is 'false'
% if only input 'fr1', 'fr2', will use 'dr = 1; scaled = true;'
% 'each' is an Nl-by-Nm matrix, the result of each {l,m} term

function [out, each] = fr2_dot(data1, data2, r, scaled)
Npw = size(data1, 2);
if nargin == 2
    each = zeros(1, Npw);
    for pw = 1:Npw
        each(pw) = sum(conj(data1(:,pw)).*data2(:,pw));
    end
    out = sum(each); return;
end

if nargin == 3, scaled = false; end
each = zeros(1, Npw);
if ~scaled
    w = r.^2;
    for pw = 1:Npw
        each(pw) = trapz(r, conj(data1(:,pw)).*data2(:,pw).*w(:));
    end
else % scaled
    for pw = 1:Npw
        each(pw) = trapz(r, conj(data1(:,pw)).*data2(:,pw));
    end
end
out = sum(each);
end
