% time evolution of 1D gaussian wave packet
% x is a vector, other inputs are scalars
% using atomic units
function psi = gaussian_wf(sigma, mass, p0, t, x, x0)
xc = x - x0 - p0*t;
psi = 1/((2*pi*sigma^2)^0.25*sqrt(1 + 1i*t/(2*mass*sigma^2))).*...
    exp(-xc.^2/((2*sigma)^2*(1+1i*t/(2*mass*sigma^2)))).*...
    exp(1i*p0*xc);
end
