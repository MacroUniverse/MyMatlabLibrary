% dcoulomb1 test

% plot coulomb function
close all;

%% scaled, asymptotic 'sin(x ...)'
rmax = 10; Nr = 100; k = 1;
r = linspace(0.01, rmax, Nr);
figure; hold on;
title(['coulomb functions, Z = -1, k = ', num2str(k)]);

for l = 0:2
    plot(r, D(@(r)coulomb1(l,k,r),r), '+');
    plot(r, dcoulomb1(l,k,r), '.');
end
