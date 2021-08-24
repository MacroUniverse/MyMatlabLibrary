x = linspace(-5, 5, 50);
y = linspace(-5, 5, 50);
[X,Y] = ndgrid(x, y);
Z = (X.^2 - Y.^2)/10;
figure; surf(X,Y,Z); axis equal;
surf2stl('surf2stl_demo.stl', X, Y, Z);
