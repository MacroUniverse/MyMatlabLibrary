function [ind1, ind2] = rand2choose(N)
while true
    ind1 = round(N*rand() + 0.5);
    ind2 = round(N*rand() + 0.5);
    if ind1 ~= ind2
        return;
    end
end
end
