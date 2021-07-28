% coulomb function of the first kind
% 'scaled' is 'true' by default, asymptotic form is 'sin(kr + ...)'
% 'l','k' are scalars, 'r' is a vector
% "r >= 0" and "k > 0.0023" is required.
% efficiency : 4e-3 [s/eval]
% TODO: fix this! At least support k = 0.
% TODO: not sure if k < 0 works.
% see PhysWiki for detail
% https://en.wikipedia.org/wiki/Coulomb_wave_function
% http://mathworld.wolfram.com/CoulombWaveFunction.html

function F = coulomb1_sym(l,k,r,Z,scaled)
if ~exist('Z','var') || isempty(Z), Z = -1; end
if ~exist('scaled','var') || isempty(scaled), scaled = true; end

eta = Z/k; rho = k*r;
C = (-0.5i)^(l+1)*2^l*....
    exp(-pi*eta*0.5)*abs(gamma_sym(l+1+1i*eta))/factorial(2*l+1);

% C is 0 or finite
if ~(isnan(C) || isinf(C) || C == 0)
    goodC = true;
    F = real(C*whittakerM(1i*eta, l+0.5, 2i*rho));
    if ~scaled % unscaled
        mark = (r > eps);
        F(mark) = F(mark)./r(mark);
        if abs(l) < eps
            F(~mark) = (2i)^(l+1)*k*C;
        else
            F(~mark) = 0;
        end
    end
    ind = find(isnan(F(:)) | isinf(F(:)));
    if isempty(ind), return; end
else
    goodC = false;
end

% use symbolic C and whittackerM
% TODO : not fully tested yet

l = sym(l); eta = sym(eta);
C = (-0.5i)^(l+1)*2^l*....
    exp(-pi*eta*0.5)*abs(gamma(l+1+1i*eta))/factorial(2*l+1);
if isnan(C) || isinf(C) || C == 0
    error('symbolic failed! TODO: fix this by using modified bessel function.');
end
C16 = vpa(C, 16);

if ~goodC
    warning('using slow mode ("C" is bad)');
    for ii = 1:numel(rho)
        temp = C16*whittakerM(1i*eta, l+0.5, 2i*rho(ii));
        F(ii) = real(double(temp));
    end
else
    warning('using slow mode ("C" is good)');
    for ii = 1:numel(ind)
        temp = C16*whittakerM(1i*eta, l+0.5, 2i*rho(ind(ii)));
        F(ind(ii)) = real(double(temp));
    end
end

% unscaled
if ~scaled
    mark = (r > eps);
    F(mark) = F(mark)./r(mark);
    if abs(l) < eps
        F(~mark) = real(double(k*C16/(-0.5i)^(l+1)));
    else
        F(~mark) = 0;
    end
end

if any(isnan(F) | isinf(F))
    warning('bad output detected!');
end
end
