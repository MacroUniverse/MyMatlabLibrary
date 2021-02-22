% plot vertical lines across the 2D figure
function h = plot_hori(y, varargin)
for i = 1:numel(y)
    ax = axis;
    h = plot(ax(1:2), [y(i), y(i)], varargin{:});
end
end
