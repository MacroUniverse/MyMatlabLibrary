%在曲线周围生成一条变半径的螺旋管道
th=((0:30)/31)';
x=zeros(size(th));
y=zeros(size(th));
z=th;
M=[x,y,z];
[Ax,Ay,Az]=CutLine(x,y,z);
L=Sline(x,y,z);
A=[Ax,Ay,Az];
L=[L,L,L];
Lend=L(end);
A=A.*sqrt(1-L/Lend);   
[X,Y,Z]=ring3D(M,A,40);
[X,Y,Z]=turnA(X,Y,Z,[0 0 -1]);
surf(X,Y,Z);
axis equal;axis vis3d;
shading interp
light;
view(58,14)
    
   
    