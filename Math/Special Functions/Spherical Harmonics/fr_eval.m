% evaluate "fr" function on a mesh in spherical coord.
% one of 'th', 'ph' must be scalar, the other is a scalar or a vector
% The output vars will have size [Nr,Nth] or [Nr,Nph]
% use 'surfSph(R,Th,Ph,f,...)' to plot the result
% 'scaled = true' if wave function is scaled, default is 'false'
% TODO: should be able to use a scalar and (th,ph) mesh

function [f, R, Th, Ph] = fr_eval(fr, l, m, r, th, ph, scaled)
if nargin < 7, scaled = false; end
th = th(:)'; ph = ph(:)';
Nr = numel(r); Nth = numel(th); Nph = numel(ph);
Nl = numel(l); Nm = numel(m);
if Nth == 1
    [R,Ph] = ndgrid(r,ph); Th = th*ones(Nr,Nph); f = zeros(Nr,Nph);
    for jj = 1:Nl
    for kk = 1:Nm
        if abs(m(kk)) > l(jj), continue; end
        f = f + fr{jj,kk}(:) .* SphHarm(l(jj),m(kk),th*ones(1,Nph),ph);
    end
    end
elseif Nph == 1
    [R,Th] = ndgrid(r,th); Ph = ph*ones(Nr,Nth); f = zeros(Nr,Nth);
    for jj = 1:Nl
    for kk = 1:Nm
        if abs(m(kk)) > l(jj), continue; end
        f = f + fr{jj,kk}(:) .* SphHarm(l(jj),m(kk),th,ph*ones(1,Nth));
    end
    end
else
    error('"th" or "ph" must be scalar!');
end
if scaled
    f = f./R;
    if r(1) < eps, error('divided by 0!'); end
end
end
