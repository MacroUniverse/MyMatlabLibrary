%通过角边角的已知条件解三角形
%逆时针排列顺序为j1,b1,j2,b2,j3,b3
%只有一解或无解
function [b2,j3,b3]=jbj(j1,b1,j2)

if j1+j2>=pi || b1<=0
    b2=[]; j3=[]; b3=[]; 
    warning('no single solution');
    return; 
end

C=[cos(j1) cos(j2); sin(j1) -sin(j2)];
b=[b1;0];
temp=C\b;
b3=temp(1); b2=temp(2);
j3=acos((b2^2+b3^2-b1^2)/(2*b2*b3));

end