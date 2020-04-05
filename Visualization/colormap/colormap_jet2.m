% colormap_jet() with black 0 point, i.e. shifting 1/8 to the right
function rgb = colormap_jet2(val)
val = val(:); N = numel(val);

m1 = 0 <= val & val < 2/8;
m2 = 2/8 <= val & val < 4/8;
m3 = 4/8 <= val & val < 6/8;
m4 = 6/8 <= val & val <= 1;

r = zeros(N, 1); g = r; b = r;

r(m1) = 0;
r(m2) = 0;
r(m3) = 4*(val(m3) - 4/8);
r(m4) = 1;

g(m1) = 0;
g(m2) = 4*(val(m2) - 2/8);
g(m3) = 1;
g(m4) = 1-4*(val(m4) - 6/8);

b(m1) = 4*val(m1);
b(m2) = 1;
b(m3) = 1-4*(val(m3) - 4/8);
b(m4) = 0;

rgb = uint8(255*[r, g, b]);
end
