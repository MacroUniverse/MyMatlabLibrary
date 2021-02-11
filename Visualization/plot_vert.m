% plot vertical lines across the 2D figure
function plot_vert(x)
for i = 1:numel(x)
    ax = axis;
    plot([x(i), x(i)], ax(3:4), 'c');
end
end
