function y = polyval_sym(c, x)
y = c(1);
for n = 1:numel(c)-1
    y = y.*x + c(n+1);
end
end
