%生成一个圆环管道
clear
clc
th=((0:200)/201*2*pi*1.5)';
x=5*cos(th);
y=5*sin(th);
z=zeros(size(th));
M=[x,y,z];
[Ax,Ay,Az]=TangentLine(x,y,z);

A=[Ax,Ay,Az];
S=Sline(x,y,z);
S=[S,S,S];
A=A.*(5-S/10);

[X,Y,Z]=ring3D(M,A,40);
[X,Y,Z]=turnA(X,Y,Z,[1 1 1]);
surf(X,Y,Z);
axis equal;axis vis3d;
shading interp
light;
view(58,14)
axis off
    
   
    