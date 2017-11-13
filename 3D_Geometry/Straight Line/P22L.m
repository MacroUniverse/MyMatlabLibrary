%空间中两点确定一条直线

function L=P22L(P1,P2)
L=[P1,vunit(P2-P1)];
end