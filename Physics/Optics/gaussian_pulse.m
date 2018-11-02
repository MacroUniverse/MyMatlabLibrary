% generate a gaussian pulse $f(t)$ (complex)
% sigma is full widths at half intensity (E0^2)

function f = gaussian_pulse(E0, w0, FWHM, tc, phi0)
f = @(t) E0*exp(-1i*w0*(t-tc) - 2*log(2)*((t-tc)/FWHM).^2 + phi0);
end
