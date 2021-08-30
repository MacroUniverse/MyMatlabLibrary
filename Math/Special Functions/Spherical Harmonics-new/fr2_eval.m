% fr_eval2
% similar to fr_eval()
% data(:,i) is the l(i), m(i) partial wave
% numel(l) = numel(m) = size(data, 2), numel(r) = size(data, 1)
function [F, R, Th, Ph] = fr2_eval(data, l, m, r, th, ph, scaled, rrange, rstep)
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
if Nth == 1
    [R,Ph] = ndgrid(r1,ph); Th = th*ones(Nr,Nph); F = zeros(Nr,Nph);
    [R,Th,Ph] = sph_wrap(R,Th,Ph);
    for pw = 1:Npw
        F = F + data(mask, pw) .* SphHarm(l(pw),m(pw),th*ones(size(ph)),ph);
    end
elseif Nph == 1
    [R,Th] = ndgrid(r1,th); Ph = ph*ones(Nr,Nth); F = zeros(Nr,Nth);
    [R,Th,Ph] = sph_wrap(R,Th,Ph);
    for pw = 1:Npw
        F = F + data(mask,pw) .* SphHarm(l(pw),m(pw),th,ph*ones(Nth, 1));
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
