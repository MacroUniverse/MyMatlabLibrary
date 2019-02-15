% coulomb function H+ and derivative
% performance is half of whittakerW()
% coulombH+ = coulombF + i*coulombG
% coulombH- = conj(coulombH+) is trivial

function [dH, H] = dcoulombHp_sym(l,eta,rho)
sigma = angle(gamma_sym(l + 1 + 1i*eta)); % coulomb phase shift
C = (-1i)^l*exp(pi*eta*0.5 + 1i*sigma);

% C is 0 or finite
if ~(isnan(C) || isinf(C) || C == 0)
    goodC = true;
    [dH, H] = dwhittakerW_sym(-1i*eta, l+0.5, -2i*rho);
    H = C*H;
    dH = -2i*C*dH;
    ind = find(isnan(dH(:)) | isinf(dH(:)));
    if isempty(ind), return; end
else
    goodC = false;
end

dummy(goodC, ind);
error('failed!');
end
