% use the same color to plot next object
function keep_color
Ncolor = size(get(gca, 'ColorOrder'), 1);
icolor = get(gca, 'ColorOrderIndex');
set(gca, 'ColorOrderIndex', mod(icolor-2, Ncolor)+1);
end
