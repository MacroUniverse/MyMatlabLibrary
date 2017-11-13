% Discrete Fourier Transform (DFT)

function f=iDFT(g)
N = numel(g);
f = zeros(size(g));
E0 = exp(2i*pi/N);
Ep = 1/E0;
for p = 0: Nk-1
    Ep = Ep*E0;
    Epq = 1/Ep;
    for q = 0:Nk-1
        Epq = Epq*Ep;
        g(p+1) = g(p+1)+Epq*f(q+1);
    end
end
end