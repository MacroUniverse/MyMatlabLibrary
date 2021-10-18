function ret = coulomb_sigma(l, eta)
ret = double(angle(gamma(l+sym(1)+1i*eta)));
end
