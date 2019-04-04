% demo : project wave function onto coulomb wave function

close all;
scaled = true; % scaled wave function

%% Hydrogen ground state (zero projection)

rmax = 25; Nr = 1801; % for 1e-8 accuracy

r = linspace(0,rmax,Nr);
fr = cell(1,1);
fr{1,1} = 2*exp(-r).*r.^scaled;
l = 0; m = 0;
ph1 = linspace(0,2*pi,200);
[f, R, Th, Ph] = fr_eval(fr, l, m, r, pi/2, ph1, scaled);
figure; surfSph(R,Th,Ph,abs(f)); view(0,90);
axis([-rmax,rmax,-rmax,rmax]);

k = linspace(0.01, 1.5, 50);

fk = fr_fft_coulomb(fr,r,l,m,k,-1,scaled);
[spec,k1] = fr_eval1(fk,l,m,k,0.1,0.3,scaled);
figure; title('Hydrogen 1s coulomb spectrum'); hold on;
plot(k1, abs(spec),'.'); hold on; % should be zero
