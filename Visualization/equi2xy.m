% the inverse of function xy2equi
function [x1, y1] = equi2xy(x, y)
xrange = get(gca, 'XLim');
yrange = get(gca, 'YLim');
aspect = get(gca, 'PlotBoxAspectRatio');
aspect = aspect(2)/aspect(1);

x1 = x * (xrange(2) - xrange(1));
y1 = y * ((yrange(2) - yrange(1))/aspect);
end
