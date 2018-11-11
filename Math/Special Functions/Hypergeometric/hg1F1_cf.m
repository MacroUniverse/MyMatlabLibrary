% evaluate 1F1(x) using continued fraction

function y = hg1F1_cf(a, b, x, N)
digits(40);
n = sym(1:N); a = sym(a); b = sym(b);
c = (a+n)./((n+1).*(b+n));
term = sym(1);
vpaterm = vpa(1,100);
for ii = N:-1:1
    term = 1-1/(1 + term/(c(ii)*x));
    vpaterm = 1-1/(1 + vpaterm/(c(ii)*x));
    if abs(term-vpaterm) > 0.001
        zzz = 1;
    end
end
y = double(1 + a/b*x/vpaterm);
% figure; plot(real(term),'.-'); hold on; plot(imag(term),'.-');
end
