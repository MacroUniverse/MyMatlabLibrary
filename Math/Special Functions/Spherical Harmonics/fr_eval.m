% evaluate "fr" function on a mesh in spherical coord.
% 'r' must be the grid points of 'fr'
% one of 'th', 'ph' must be scalar, the other is a scalar or a vector
% 'th' and 'ph' have no range limit
% The output vars will have size [Nr,Nth] or [Nr,Nph]
% use 'surfSph(R,Th,Ph,f,...)' to plot the result
% 'scaled = true' if wave function is scaled, default is 'false'
% when 'scaled = true' and 'r(1) = 0', "f(0)" is replaced with "mean(f(r(2)))"
% TODO: should be able to use a scalar and (th,ph) mesh

function [F, R, Th, Ph] = fr_eval(fr, l, m, r, th, ph, scaled)
if nargin < 7, scaled = false; end
th = th(:)'; ph = ph(:)';
Nr = numel(r); Nth = numel(th); Nph = numel(ph);
Nl = numel(l); Nm = numel(m);
if Nth == 1
    [R,Ph] = ndgrid(r,ph); Th = th*ones(Nr,Nph); F = zeros(Nr,Nph);
    [R,Th,Ph] = sph_wrap(R,Th,Ph);
    for jj = 1:Nl
    for kk = 1:Nm
        if abs(m(kk)) > l(jj), continue; end
        F = F + fr{jj,kk}(:) .* SphHarm(l(jj),m(kk),th*ones(1,Nph),ph);
    end
    end
elseif Nph == 1
    [R,Th] = ndgrid(r,th); Ph = ph*ones(Nr,Nth); F = zeros(Nr,Nth);
    [R,Th,Ph] = sph_wrap(R,Th,Ph);
    for jj = 1:Nl
    for kk = 1:Nm
        if abs(m(kk)) > l(jj), continue; end
        F = F + fr{jj,kk}(:) .* SphHarm(l(jj),m(kk),th,ph*ones(1,Nth));
    end
    end
else
    error('"th" or "ph" must be scalar!');
end
if scaled
    if r(1) < eps
        F(2:end,:) = F(2:end,:)./R(2:end,:);
        F(1,:) = mean(F(2,:));
    else
        F = F./R;
    end
end
end
