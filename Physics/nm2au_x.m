% convert length from nm to atomic unit
function out = nm2au_x(nm)
load constants.mat au_x;
out = nm*(1e-9/au_x);
end
