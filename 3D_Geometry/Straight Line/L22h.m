%计算两条直线的距离(6参数)(利用法向量)

function dist=L22h(L1,L2)

vn=vlaw(L1(4:6),L2(4:6));
r=L1(1:3)-L2(1:3);
dist=abs(dot(r,vn));
end