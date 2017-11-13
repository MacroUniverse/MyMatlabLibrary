% ode file to solve TISE bound states.
function dY=BoundOde(x,Y,V,E)
dY(2,1)=2*(V(x)-E)*Y(1);
dY(1)=Y(2);
end