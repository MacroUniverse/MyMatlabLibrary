% 3d version of fr2_eval
% data(:,i) is the l(i), m(i) partial wave
% numel(r) = size(data, 1)
% output vars has coord. ndgrid(r, th, ph)

function [F, R, Th, Ph] = fr2_eval_3d(data, l, m, r, th, ph, ...
    scaled, rrange, rstep) % optional
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
Npw = numel(l);
if (size(data,2) ~= Npw || numel(m) ~= Npw)
    error('argument size error!');
end

[R,Th,Ph] = ndgrid(r1,th,ph);
[R,Th,Ph] = sph_wrap(R,Th,Ph);
F = zeros(Nr, Nth, Nph);
[~,Th2,Ph2] = ndgrid(1,th,ph);
for pw = 1 : Npw
    F = F + data(mask,pw) .* SphHarm(l(pw),m(pw),Th2,Ph2);
end

if scaled
    if r1(1) < eps
        F(2:end,:,:) = F(2:end,:,:) ./ R(2:end,:,:);
        F(1,:,:) = mean(F(2,:,:));
    else
        F = F ./ R;
    end
end
end
