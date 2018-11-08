% plot coulomb function
close all;

%% scaled, asymptotic 'sin(x ...)'
rmax = 1000; Nr = 100; k = 2;
l = 0:3; Nl = numel(l);
r = linspace(0, rmax, Nr);
figure; hold on;
title(['coulomb functions, Z = -1, k = ', num2str(k)]);

tic;
for ii = 1:Nl
    F = coulomb1(l(ii),k,r);
    Fmex = coulomb1_mex(l(ii),k,r);
    disp(max(F-Fmex));
    plot(r, F);
end
disp(['time/eval = ' num2str(toc/(Nl*Nr))]);

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
