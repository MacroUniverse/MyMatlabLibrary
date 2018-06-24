%已知边角边, 解三角形
function [j2,b3,j3]=bjb(b1,j1,b2)
if ~(b1>0 && b2>0 && j1>0)
    warning('no single solution');
end
b3=sqrt(b1^2+b2^2-2*b1*b2*cos(j1));
j2=acos((b2^2+b3^2-b1^2)/(2*b2*b3));
j3=acos((b1^2+b3^2-b2^2)/(2*b1*b3));
end