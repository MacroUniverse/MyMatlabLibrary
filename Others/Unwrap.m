% Npi version of unwrap
% will plus Npi*pi to match the phase if phi(ii+1)-phi(ii) > Npi*pi/2
% will minus Npi*pi to match the phase if phi(ii+1)-phi(ii) < -Npi*pi/2

function [phi,ind] = Unwrap(phi,Npi)

dphi = diff(phi);
ind = find(abs(dphi)>0.5*Npi*pi);
Sign = sign(dphi(ind));
Nind = numel(ind);
ind = [ind, numel(phi)];
Nshift = 0;
for ii = 1:Nind
    Nshift = Nshift-Sign(ii);
    phi(ind(ii)+1:ind(ii+1)) = phi(ind(ii)+1:ind(ii+1)) + Nshift*Npi*pi;
end
if nargout == 2
    ind = ind(1:end-1);
end
end