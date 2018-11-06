% plot coulomb function
close all;

%% scaled, asymptotic 'sin(x ...)'
rmax = 10; Nr = 300; k = 1;
r = linspace(0, rmax, Nr);
figure; hold on;
title(['coulomb functions, Z = -1, k = ', num2str(k)]);

for l = 0:3
    plot(r, coulomb1(l,k,r));
end

%% unscaled, asymptotic 'sin(x ...)/x'
rmax = 10; Nr = 300; k = 1;
r = linspace(0, rmax, Nr);
figure; hold on;
title(['unscaled coulomb functions, Z = -1; k = ', num2str(k)]);

for l = 0:3
    plot(r, coulomb1(l,k,r,false));
end

%% what does k = 0 look like?

rmax = 10; Nr = 300; k = 0.0023;
r = linspace(0, rmax, Nr);
figure; hold on;
title(['unscaled coulomb functions, Z = -1; k = ', num2str(k)]);

for l = 0:4
    plot(r, coulomb1(l,k,r,false));
end
