% integral of the product of three spherical harmonics
% supports symbolic input
% \int Y_{l1,m1} Y_{l2,m2} Y_{l3,m3} \dd{\Omega}
function out = ThreeYInt(l1,m1,l2,m2,l3,m3)
out = ThreeJ(l1,0,l2,0,l3,0);
if CG_check_0(out), out = 0; return; end
out = out * ThreeJ(l1,m1,l2,m2,l3,m3);
if CG_check_0(out), out = 0; return; end
out = out * sqrt((2*l1+1)*(2*l2+1)*(2*l3+1)/(4*pi));
end
