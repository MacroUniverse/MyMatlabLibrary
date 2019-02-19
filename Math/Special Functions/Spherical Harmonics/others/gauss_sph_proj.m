% projection from 3d gaussian wave to spherical wave
% the gaussian packet must be in negative z domain
% input are scalars
function prod = gauss_sph_proj(a, rc, k0, l, k, delta)
L = sqrt(1/a)*3;

%plot gaussian
% r = linspace(rc-L,rc+L,300);
% th = linspace(pi-atan(L/rc),pi+atan(L/rc),300);
% [R,Th] = ndgrid(r,th);
% figure; surfSph(R,Th,0,abs(fg(R,Th)).^2);
% figure; surfSph(R,Th,0,abs(fs(R,Th)).^2);

prod = 2*pi *integral2(@(r,th)fg(r,th,a,k0,rc).*fs(r,th,k,l,delta).*r.^2.*sin(th),....
    rc-L, rc+L, pi-atan(L/rc), pi, 'RelTol', 1e-4);
end

function out = fg(R,Th,a,k0,rc)
out = (2*a/pi)^(3/4) * exp(-a*((R.*sin(Th)).^2 + (R.*cos(Th) + rc).^2))......
    .* exp(1i*k0*R.*cos(Th));
end

function out = fs(R,Th,k,l,delta)
out = sqrt(2/pi)*k * sbesselj(l,k*R+delta).*SphHarm0(l,Th);
end
