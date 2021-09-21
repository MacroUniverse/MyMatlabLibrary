% ls_poly_demo
x = linspace(-10, 10, 100);
y = sin(x);
figure; plot(x, y);
c = ls_poly(x, y, 15);
y1 = polyval(c, x);
hold on; plot(x, y1);
axis([-10, 10, -1, 1]);