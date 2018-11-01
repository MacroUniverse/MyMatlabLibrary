% propeller pulse generator
close all;
tmin = 0; tmax = 20; Nt = 512;
t = linspace(tmin, tmax, Nt);
w1 = 3; w2 = -1;

f1 = exp(1i*w1*t);
f2 = exp(1i*w2*t);

f = f1 + f2;

figure; axis equal; hold on;

%plot(f1);
%plot(f2);
%plot(f); 

figure; plot3(t, real(f), imag(f));
xlabel t; ylabel real(f); zlabel imag(f);
axis equal;

