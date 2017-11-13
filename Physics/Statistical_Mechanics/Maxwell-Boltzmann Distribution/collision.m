%两个粒子的完全弹性碰撞
%size(v1)=size(v2)=size(m1)=size(2)=[N,3];
%A是碰撞平面的法向量
%当不输入m1,m2的时候, 默认他们相等.
function [v11,v22]=collision(v1,v2,A,m1,m2)
A=A/norm(A);
%质心的速度
vc=(m1*v1+m2*v2)/(m1+m2);
%质心系中的速度
vr1=v1-vc;
vr2=v2-vc;
%计算关于碰撞平面的反射
vr11=reflection(vr1,A);
vr22=reflection(vr2,A);
%原参考系中的速度
v11=vr11+vc;
v22=vr22+vc;
end