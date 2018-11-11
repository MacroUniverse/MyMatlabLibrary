% coulomb1_mex test

rmin = 0; rmax = 5; Nr = 500; k = 10;
l = 0:3; Nl = numel(l);
r = linspace(rmin, rmax, Nr);
figure; hold on;
title(['coulomb functions, Z = -1, k = ', num2str(k)]);

tic;
for ii = 1:Nl
    F = coulomb1(l(ii),k,r);
    Fmex = coulomb1_mex(l(ii),k,r);
    disp(['max error = ', num2str(max(abs(Fmex-F)))]);
    figure; plot(k*r, Fmex-F); title(['l = ', num2str(l(ii)), ' eta = ', num2str(-1/k)]);
    xlabel \rho; ylabel('abs err');
    %plot(r, F);
end
disp(['time/eval = ' num2str(toc/(Nl*Nr))]);
