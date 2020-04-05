% generate a model spectrum
% val must be from 0 to 1, corresponding to 400nm to 800nm
function rgb = colormap_jet(val)
val = val(:); N = numel(val);

m1 = 0 <= val & val < 1/8;
m2 = 1/8 <= val & val < 3/8;
m3 = 3/8 <= val & val < 5/8;
m4 = 5/8 <= val & val < 7/8;
m5 = 7/8 <= val & val <= 1;

r = zeros(N, 1); g = r; b = r;

r(m1) = 0;
r(m2) = 0;
r(m3) = 4*(val(m3) - 3/8);
r(m4) = 1;
r(m5) = 1-4*(val(m5) - 7/8);

g(m1) = 0;
g(m2) = 4*(val(m2) - 1/8);
g(m3) = 1;
g(m4) = 1-4*(val(m4) - 5/8);
g(m5) = 0;

b(m1) = 4*(val(m1) + 1/8);
b(m2) = 1;
b(m3) = 1-4*(val(m3) - 3/8);
b(m4) = 0;
b(m5) = 0;

rgb = uint8(255*[r, g, b]);
end
