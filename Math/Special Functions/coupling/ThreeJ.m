% wigner 3j symbol
% support symbolic input
function out = ThreeJ(j1,m1,j2,m2,j3,m3)
out = CG(j1,m1,j2,m2,j3,-m3);
if abs(double(out)) < eps
    out = 0; return;
end
out = (-1)^(j1-j2-m3)/sqrt(2*j3+1) * out;
end
