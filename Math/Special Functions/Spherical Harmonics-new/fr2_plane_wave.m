% expand a plane wave "exp(\I\vec k\vdot\vec r)" to an "fr" function
% 'r', 'l', 'm' are vectors, 'k', 'th', 'ph' are scalars
% 'r' is radial grid, 'l', 'm' are indices for spherical harmonics
% 'k' is the wave number (can be any real number)
% 'th','ph' are polar angles 'theta' and 'phi'
% set 'scaled = true' to output scaled 'fr', default is 'false'

function data = fr2_plane_wave(r,l,m,k,th,ph,scaled)
if nargin < 7, scaled = false; end
[k,th,ph] = sph_wrap(k,th,ph);
Npw = numel(l); Nr = numel(r);
data = zeros(Nr, Npw);
for pw = 1:Npw
    jl_kr = sbesselj(l(pw), k*r);
    data(:, pw) = 4*pi*1i^l(pw)*conj(SphHarm(l(pw),m(pw),th,ph))*jl_kr;
end
if scaled
    data = data .* r(:);
end
end
