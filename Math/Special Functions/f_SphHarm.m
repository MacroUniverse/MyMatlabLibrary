% evaluate function from spherical harmonic form on a surface
% f(\vec r) = \sum_{lm} f_R_{lm}(r) Y_{lm}(\uvec r)
% size(R) = [Nr, Nl, Nm]
% R_{l_j,m_k}(r(:)) = R(:,Nk*(j-1)+k)
% 'f_R' and 'r' are vector of same size
% one of 'th', 'ph' must be scalar, the other is a scalar or a vector
% The output vars will have size [Nr,Nth] or [Nr,Nph]

function [f, R, Th, Ph] = f_SphHarm(f_R, l, m, r, th, ph)
th = th(:)'; ph = ph(:)';
Nr = numel(r); Nth = numel(th); Nph = numel(ph);
Nl = numel(l); Nm = numel(m);
if Nth == 1
    [R,Ph] = ndgrid(r,ph); Th = th*ones(Nr,Nph); f = zeros(Nr,Nph);
    for jj = 1:Nl
    for kk = 1:Nm
        if abs(m(kk)) > l(jj), continue; end
        Y_lm = SphHarm(l(jj),m(kk),th*ones(1,Nph),ph);
        for ii = 1:Nr
            f(ii,:) = f(ii,:) + f_R(ii,jj,kk) * Y_lm;
        end
    end
    end
elseif Nph == 1
    [R,Th] = ndgrid(r,th); Ph = ph*ones(Nr,Nth); f = zeros(Nr,Nth);
    for jj = 1:Nl
    for kk = 1:Nm
        if abs(m(kk)) > l(jj), continue; end
        Y_lm = SphHarm(l(jj),m(kk),th,ph*ones(1,Nth));
        for ii = 1:Nr
            f(ii,:) = f(ii,:) + f_R(ii,jj,kk) * Y_lm;
        end
    end
    end
else
    error('"th" or "ph" must be scalar!');
end
end
