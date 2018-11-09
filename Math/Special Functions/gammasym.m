% symbolic calculation of gamma function
% supports complex input

function z = gammasym(z)
for ii = 1:numel(z)
    z(ii) = double(gamma(sym(z(ii))));
end
end
