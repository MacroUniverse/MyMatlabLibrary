% test precision of coulomb1_f()

%% scaled, asymptotic 'sin(x ...)'
rmax = 1000; Nr = 1000;
kmin = 0.01; kmax = 10; Nk = 20;
l = 0:3; Nl = numel(l);
k = linspace(kmin,kmax,Nk);

for ii = 1:Nl
    for jj = 1:Nk
        l1 = l(ii); k1 = k(jj);
        r = rand(1,Nr)*rmax;
        err = abs(kummerM2(l1+1+1i/k1, 2*l1+2, 1i*k1*r) - hypergeom(l1+1+1i/k1, 2*l+2, 1i*k1*r));
    end
end
