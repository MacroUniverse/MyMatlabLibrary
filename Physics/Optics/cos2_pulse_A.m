% IR vector potential for cos2 laser pulse (eq_cos2wp_2)

function A = cos2_pulse_A(t, t0, Ef0, w, w0)
A = zeros(size(t));
tmax = pi/(2*w0);
ma = (abs(t-t0) < tmax);
tt = t(ma)-t0;
A(ma) = Ef0/4*(cos((2*w0+w)*tt)/(2*w0+w) ....
    - cos((2*w0-w)*tt)/(2*w0-w) + 2*cos(w*tt)/w) ...
    - 2*Ef0*w0^2*cos((pi*w)/(2*w0))/(w*(4*w0^2-w^2));
end
