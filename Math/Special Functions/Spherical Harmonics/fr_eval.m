% evaluate a 3D function on a 2D mesh in spherical coord.
% see README.txt
% 'r' must be the grid points of 'fr'
% one of 'th', 'ph' must be scalar, the other is a scalar or a vector
% 'th' and 'ph' have no range limit, will be wrapped
% The outputs will have size [Nr,Nth] or [Nr,Nph]
% use 'surfSph(R,Th,Ph,f,...)' to plot the result
% 'scaled = true' if wave function is scaled, default is 'false'
% when 'scaled = true' and 'r(1) = 0', "f(0)" is replaced with "mean(f(r(2)))"
% 'rrange' (numel=2) specifies range of 'r', default is whole range.
% 'rstep' specifies radial step length, default is 1
% TODO: should be able to use a scalar r and (th,ph) mesh

function [F, R, Th, Ph] = fr_eval(fr, l, m, r, th, ph, scaled, rrange, rstep)
if ~exist('scaled','var') || isempty(scaled)
    scaled = false;
end
if ~exist('rrange','var') || isempty(rrange)
    rrange = [-inf,inf];
end
if ~exist('rstep','var') || isempty(rstep)
    rstep = 1;
end
mask = false(1,numel(r));
mask(lookupR(r,rrange(1),true):rstep:lookupL(r,rrange(2),true)) = true;
r1 = r(mask);
th = th(:)'; ph = ph(:)';
Nr = numel(r1); Nth = numel(th); Nph = numel(ph);
Nl = numel(l); Nm = numel(m);
if Nth == 1
    [R,Ph] = ndgrid(r1,ph); Th = th*ones(Nr,Nph); F = zeros(Nr,Nph);
    [R,Th,Ph] = sph_wrap(R,Th,Ph);
    for jj = 1:Nl
    for kk = 1:Nm
        if isempty(fr{jj,kk}), continue; end
        F = F + fr{jj,kk}(mask).' .* SphHarm(l(jj),m(kk),th*ones(1,Nph),ph);
    end
    end
elseif Nph == 1
    [R,Th] = ndgrid(r1,th); Ph = ph*ones(Nr,Nth); F = zeros(Nr,Nth);
    [R,Th,Ph] = sph_wrap(R,Th,Ph);
    for jj = 1:Nl
    for kk = 1:Nm
        if isempty(fr{jj,kk}), continue; end
        F = F + fr{jj,kk}(mask).' .* SphHarm(l(jj),m(kk),th,ph*ones(1,Nth));
    end
    end
else
    error('"th" or "ph" must be scalar!');
end
if scaled
    if r1(1) < eps
        F(2:end,:) = F(2:end,:)./R(2:end,:);
        F(1,:) = mean(F(2,:));
    else
        F = F./R;
    end
end
end
