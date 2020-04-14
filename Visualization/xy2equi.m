% map x, y coordinates to x1, y1 with equal axis
% x range is [0 1], y range [0, ymax] depending on aspect ratial
function [x1, y1] = xy2equi(x, y)
xrange = get(gca, 'XLim');
yrange = get(gca, 'YLim');
aspect = get(gca, 'PlotBoxAspectRatio');
aspect = aspect(2)/aspect(1);

x1 = x / (xrange(2) - xrange(1));
y1 = y / (yrange(2) - yrange(1)) * aspect;
end
