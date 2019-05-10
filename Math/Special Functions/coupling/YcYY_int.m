% integrate the product of three spherical harmonics
% where the first Y is conjugated
function out = YcYY_int(l1,m1,l2,m2,l3,m3)
out = (-1)^m1*YYY_int(l1,-m1,l2,m2,l3,m3);
end
