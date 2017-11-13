% if scalar n is one element of the list matrix

function [tf,ind] = inside(n,list)
tf = 0;
for ii = 1:numel(list)
    if n == list(ii)
        tf = 1;
        ind = ii;
        return;
    end
end
ind = 0;
end