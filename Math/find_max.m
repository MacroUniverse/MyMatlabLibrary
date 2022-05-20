% find local maximum of discrete function y(x_i), starting from x = x0
function ind = find_max(x, y, x0)
N = numel(x);
[~,ind] = min(abs(x-x0));
dir = sign(y(ind+1) - y(ind));
if dir > 0
    while true
        if ind + 1 <= N && y(ind) <= y(ind+1)
            ind = ind + 1;
        else
            break;
        end
    end
elseif dir < 0
    while true
        if ind - 1 > 0 && y(ind) <= y(ind-1)
            ind = ind - 1;
        else
            break;
        end
    end
end
end
