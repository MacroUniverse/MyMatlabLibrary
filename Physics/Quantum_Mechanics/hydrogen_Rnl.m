function ret = hydrogen_Rnl(Z,n,l,r)
ret = sqrt((2*Z/n)^3*factorial(n-l-1)/(2*n*factorial(n+l))) *...
        (2*Z*r/n).^l .* laguerreL(n-l-1, 2*l+1, 2*Z*r/n) .* exp(-Z*r/n);
end
