% physics version of sph2cart
function [X,Y,Z] = Sph2Cart(R,Th,Ph)
[X,Y,Z] = sph2cart(Ph,pi*0.5-Th,R);
end
