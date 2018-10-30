% find unscaled radial function for a plane wave
function f_R = plane_wave_sph(r,l,m,k,th,ph)
r = r(:);
Nr = numel(r); Nl = numel(l); Nm = numel(m);
f_R = zeros(Nr,Nl,Nm);
for jj = 1:Nl
    jl_kr = sbesselj(l(jj), k*r);
    for kk = 1:Nm
        if abs(m(kk)) > l(jj), continue; end
        f_R(:,jj,kk) = 4*pi*1i^(l(jj))*conj(SphHarm(l(jj),m(kk),th,ph))*jl_kr;
    end
end
end
