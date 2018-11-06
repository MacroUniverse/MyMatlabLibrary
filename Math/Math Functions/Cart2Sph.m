% physics version of sph2cart
function [R,Th,Ph] = Cart2Sph(X,Y,Z)
[Ph,Th,R] = cart2sph(X,Y,Z);
Th = pi*0.5 - Th;
end
