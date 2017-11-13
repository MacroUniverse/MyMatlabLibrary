% find the ind_th nonzero root of besselj function (ind can be vector)
% ind must be in ascending order, must be positive integer.
% using multi-interval bissection algorithm, with interval pi.
% allows integer and half integer l
% tested for l <= 11

function root = besseljzero(l,ind)
kk = 0; % number of zeros found
ind_max = max(ind);
Nind = numel(ind);
root = zeros(1,Nind);
xL = 0.01; xR = xL + pi;
signL = besselj(l,xL); signR = besselj(l,xR);
ii = 1; % ind(ii)_th root is to be found.
while kk < ind_max
    if signR == 0
        kk = kk + 1; root(kk) = xR;
        xL = xR + pi-0.01; xR = xL + pi;
        signL = besselj(l,xL); signR = besselj(l,xR);
        continue;
    elseif signL*signR < 0 % exist root
        kk = kk + 1;
        if kk == ind(ii)
            root(ii) = fzero(@(x)besselj(l,x),[xL,xR]);
            ii = ii + 1;
        end
    end
    xL = xR; xR = xL + pi;
    signL = signR; signR = besselj(l,xR);
end

end