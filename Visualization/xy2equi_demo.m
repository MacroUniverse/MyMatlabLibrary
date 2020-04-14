figure; axis([-800,1000,-0.8,1]);
set(gca, 'PlotBoxAspectRatio', [0.5, 1, 0.5]);
% plot a square
x = [0 1 1 0 0]/3-0.5/3;
y = [0 0 1 1 0]/3-0.5/3;
[x1, y1] = equi2xy(x, y);
hold on; plot(x1, y1);
axis([-1000,1000,-1,1]);
[x2, y2] = xy2equi(x1, y1);
% check x2 == x, y2 == y
if norm(x2 - x) + norm(y2 - y) > 1e-14
    error('something wrong');
end
