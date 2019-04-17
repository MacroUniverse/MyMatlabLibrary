% wigner 3j symbol
% support symbolic input
function out = ThreeJ(j1,m1,j2,m2,j3,m3)
out = (-1)^(j1-j2-m3)/sqrt(2*j3+1) * CG(j1,m1,j2,m2,j3,-m3);
end
