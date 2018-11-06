% expand a plane wave "exp(\I\vec k\vdot\vec r)" to an "fr" function
% 'r', 'l', 'm' are vectors, 'k', 'th', 'ph' are scalars
% 'r' is radial grid, 'l', 'm' are indices for spherical harmonics
% 'k' is the wave number (can be any real number)
% 'th','ph' are polar angles 'theta' and 'phi'
% set 'scaled = true' to output scaled 'fr', default is 'false'

function fr = fr_plane_wave(r,l,m,k,th,ph,scaled)
if nargin < 7, scaled = false; end
[k,th,ph] = sph_wrap(k,th,ph);
Nl = numel(l); Nm = numel(m);
fr = cell(Nl,Nm);
for jj = 1:Nl
    jl_kr = sbesselj(l(jj), k*r);
    for kk = 1:Nm
        if abs(m(kk)) > l(jj), continue; end
        fr{jj,kk} = 4*pi*1i^l(jj)*conj(SphHarm(l(jj),m(kk),th,ph))*jl_kr;
    end
end
if scaled
    fr = fr_mul(fr, r);
end
end
