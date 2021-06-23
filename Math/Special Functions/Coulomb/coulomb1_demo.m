% plot coulomb function
close all;

%% scaled, asymptotic 'sin(x ...)'
rmin = 0; rmax = 10; Nr = 301; k = 1;
l = 0:3; Nl = numel(l);
%r = rand(1,Nr)*(rmax-rmin)+rmin;
r = linspace(rmin,rmax,Nr);
figure; hold on;
title(['coulomb functions, Z = -1, k = ', num2str(k)]);

%tic;
for ii = 1:Nl
    tic; F1 = coulomb1_sym(l(ii),k,r,-1,true); toc
    % tic; F = coulomb1(l(ii),k,r,-1,true); toc
    plot(r, F1);
end
%disp(['time/eval = ' num2str(toc/(Nl*Nr))]);

%% unscaled, (asymptotic 'sin(x ...)/x')
rmax = 10; Nr = 1000; k = 2;
l = 0:3; Nl = numel(l);
r = linspace(0, rmax, Nr);
figure; hold on;
title(['coulomb functions, Z = -1, k = ', num2str(k)]);

tic;
for ii = 1:Nl
    F = coulomb1(l(ii),k,r);
    Fmex = coulomb1_mex(l(ii),k,r);
    disp(['max error = ', num2str(max(abs(F-Fmex)))]);
    plot(r, F);
end
disp(['time/eval = ' num2str(toc/(Nl*Nr))]);

%% what does k = 0 look like?

rmax = 10; Nr = 300; k = 0.0023;
r = linspace(0, rmax, Nr);
figure; hold on;
title(['unscaled coulomb functions, Z = -1; k = ', num2str(k)]);

for l = 0:4
    plot(r, coulomb1(l,k,r,false));
end
