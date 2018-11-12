% symbolic calculation of gamma function
% supports complex input
% efficiency: 6e-4 [s/eval]

function z = gamma_sym(z)
old = digits(16);
z = vpa(z);
z = double(gamma(z));
if any(isnan(z) | isinf(z))
    warning('bad output !');
end
digits(old);
end
