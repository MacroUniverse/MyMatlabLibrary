% test coulombHplus_sym()
close all;
l = 3; k = 2; Z = -1;
r = linspace(0.1, 30, 400);
tic; F = coulomb1_sym(l, k, r); toc;
tic; [dHp, Hp] = dcoulombHp_sym(l, Z/k, k*r); toc;
F1 = imag(Hp); dF1 = imag(dHp);
G1 = real(Hp); dG1 = real(dHp);
figure; hold on;
plot(r, F, 'b.');
plot(r, F1);
plot(r, dF1);
figure; hold on;
plot(r, G1);
plot(r, dG1);
axis([r(1),r(end),-2, 2]);

% plot(r, G1);
disp('F max abs error = ');
disp(max(abs(F - F1)));

disp('Wronskians max abs error = ');
disp(max(abs(G1.*dF1 - F1.*dG1 - 1)));
