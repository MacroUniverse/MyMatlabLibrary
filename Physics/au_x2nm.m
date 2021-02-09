% convert length from atomic unit to nm
function out = au_x2nm(x)
load constants.mat au_x;
out = x*(au_x*1e9);
end
