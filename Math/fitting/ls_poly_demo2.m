% ls_poly_demo2
order = 100;
Nx = ceil(order^2/4);
x = linspace(-1, 1, Nx);
x1 = linspace(-1, 1, Nx*8);
y = zeros(size(x));
y(x > 0) = -x(x > 0);
y(x > 0.5) = x(x > 0.5)-1;
y(x < 0) = x(x < 0);
y(x < -0.5) = -x(x < -0.5)-1;
figure; plot(x, y, '.');

writematrix([x; y], 'data.csv');

% fit
order = 30;
c0 = ls_poly(x, y, order);
y1 = polyval_sym(c0, x1);
hold on; plot(x1, y1);

% c = ls_poly_nelder_sym(x, y, c0, 1e-16);
% y2 = polyval_sym(c, x1);
% hold on; plot(x1, y2);
axis([-1, 1, -1, 1]);

% poly interp
% digits(32);
% p = poly_interp(vpa(x), vpa(y));
% y3 = polyval_sym(p, x1);
% hold on; plot(x1, y3);

c2 = ls_poly_nelder(x, y, c0, 1e-16);
y4 = polyval_sym(c2, x1);
hold on; plot(x1, y4);
axis([-1, 1, -1, 1]);

c3 = ls_poly_nelder_sym(x, y, c2, 1e-16);
y5 = polyval_sym(c3, x1);
hold on; plot(x1, y5);
axis([-1, 1, -1, 1]);

