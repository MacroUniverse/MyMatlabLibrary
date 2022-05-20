% find local minimum of discrete function y(x_i), starting from x = x0
function ind = find_min(x, y, x0)
ind = find_max(x, -y, x0);
end
