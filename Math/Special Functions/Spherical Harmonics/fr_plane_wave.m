% expand a plane wave "exp(\I\vec k\vdot\vec r)" to an "fr" function
% 'r', 'l', 'm' are vectors, 'k', 'th', 'ph' are scalars
% 'r' is radial grid, 'l', 'm' are indices for spherical harmonics
% 'k' is the wave number (can be any real number)
% 'th','ph' are polar angles 'theta' and 'phi'

function fr = fr_plane_wave(r,l,m,k,th,ph)
Nl = numel(l); Nm = numel(m);
fr = cell(Nl,Nm);
sgn = sign(k); k = abs(k);
for jj = 1:Nl
    jl_kr = sbesselj(l(jj), k*r);
    for kk = 1:Nm
        if abs(m(kk)) > l(jj), continue; end
        fr{jj,kk} = 4*pi*1i^(sgn*l(jj))*conj(SphHarm(l(jj),m(kk),th,ph))*jl_kr;
    end
end
end
