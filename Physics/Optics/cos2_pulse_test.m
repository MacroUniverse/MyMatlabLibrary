% cos2_pulse_test
w = 4; w0 = 0.2; Ef0 = 2.5; t0 = 0.5;
t = linspace(-10,10,1000);
Ef = cos2_pulse(t,t0,Ef0,w,w0);
A = cos2_pulse_A(t,t0,Ef0,w,w0);
figure; plot(t, Ef);
hold on; plot(t, -gradient(A)/(t(2)-t(1)), '.');
