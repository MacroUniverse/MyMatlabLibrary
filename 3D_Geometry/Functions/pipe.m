%在曲线周围生成一条变半径的螺旋管道
th=((0:100)/101*2*pi)';
x=4*cos(th);
y=4*sin(th);
z=th;
M=[x,y,z];
[Ax,Ay,Az]=CutLine(x,y,z);
L=Sline(x,y,z);
A=[Ax,Ay,Az];
L=[L,L,L];
%A=A.*(sin(2*L)+6)/3;
Lend=L(end);
A=A.*(1-L/Lend).^2;   
[X,Y,Z]=ring3D(M,A,40);
[X,Y,Z]=turnA(X,Y,Z,[1 1 1]);
surf(X,Y,Z);
axis equal;axis vis3d;
shading interp
light;
view(58,14)
    
   
    