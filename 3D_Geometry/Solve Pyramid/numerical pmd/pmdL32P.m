% 已知三棱锥地面的三个点坐标 P1,P2,P3, 和三条棱 L1,L2,L3, 求顶点坐标
function P = pmdL32P(L1,L2,L3,P1,P2,P3)

P12 = P2-P1; mag = norm(P12);
C1 = (L1^2+mag^2-L2^2)/(2*L1*mag);% C1 = cos<P1P,P1P2>
P12 = P12/mag;

P13 = P3-P1; mag = norm(P13);
C2 = (L1^2+mag^2-L3^2)/(2*L1*mag);% C2 = cos<P1P,P1P3>
P13 = P13/norm(P13);

% P12和P13的法向量
vn = cross(P12,P13); vn = vn/norm(vn);

% 求单位投影矢量
M33 = [P12; P13; vn]; % 方程组: xs,ys,zs的点是单位P1P在P1P2,P1P3平面上的投影矢量(单位矢量)
C = [C1; C2; 0];      % 第一条: 矢量在P1P2方向的投影 = C1
Pproj = (M33\C)';     % 第二条: 矢量在P1P3方向的投影 = C2
                      % 第三条: 矢量在(nx,ny,nz)方向的投影 = 0
%还原
a = sqrt(1-norm(Pproj)^2);
P = L1*(a*vn+Pproj)+P1;
end
