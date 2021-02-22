% plot vertical lines across the 2D figure
function h = plot_vert(x, varargin)
for i = 1:numel(x)
    ax = axis;
    h = plot([x(i), x(i)], ax(3:4), varargin{:});
end
end
