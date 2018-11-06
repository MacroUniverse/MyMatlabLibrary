% convert "general" spherical coordinates to spherical coordinates
% the former allows any real 'r', 'th', 'ph'
% the latter requires 'r > 0', '0 <= th <= pi', '-pi < ph <= pi'
% R, Th, Ph must have the same shape, except R could be empty
% when R is empty, cannot output R

function [R,Th,Ph] = sph_wrap(R,Th,Ph)
if ~isempty(R)
% correct R
maskR = (R < 0);
R(maskR) = -R(maskR);
Th(maskR) = Th(maskR) + pi;
end

% correct theta
Th = mod(Th, 2*pi);
maskTh = (Th > pi);
Th(maskTh) = 2*pi - Th(maskTh);
Ph(maskTh) = Ph(maskTh) + pi;

% correct phi
Ph = mod(Ph+pi, 2*pi)-pi;
end
