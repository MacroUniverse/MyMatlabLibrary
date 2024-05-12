% IR vector potential for cos2 laser pulse (eq_cos2wp_2)

function Ef = cos2_pulse(t, t0, Ef0, w, w0)
tmax = pi/(2*w0);
ma = (abs(t-t0) < tmax);
tt = t(ma) - t0;
Ef = zeros(size(t));
Ef(ma) = Ef0 * cos(w0*tt).^2 .* sin(w*tt);
end
