function [ret, ind] = lookup(v, s)
error('this function is unverified!');
N = numel(v); ind1 = 1; ind2 = N;
if N < 1
    error("empty container!");
end
if s < v(1)
    ind = 0; ret = false; return;
elseif s == v(1)
    ind = 0; ret = true; return;
end
if s > v(ind2)
    ind = N; ret = false; return;
end
if s == v(ind2)
    ind = ind2; ret = true; return;
end
% N > 2 from here
while true
    ind = (ind1 + ind2) / 2;
    if s < v(ind)
        ind2 = ind;
    elseif s > v(ind)
        ind1 = ind;
    else
        ret = true; return;
    end
    if ind2 - ind1 == 1
        ind = ind1; ret = false; return;
    end
end
end
