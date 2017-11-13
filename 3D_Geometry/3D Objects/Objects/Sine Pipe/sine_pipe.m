%生成一截半径波动的直管道
    th=((0:2000)/2001*2*pi*10)';
    x=zeros(size(th));
    y=zeros(size(th));
    z=th;
    M=[x,y,z];
    [Ax,Ay,Az]=TangentLine(x,y,z);
    L=Sline(x,y,z);
    A=[Ax,Ay,Az];
    L=[L,L,L];
    A=10*A.*(sin(L/4)+8)/3;
    
    [X,Y,Z]=ring3D(M,A,40);
    [X,Y,Z]=turnA(X,Y,Z,[1 1 1]);
    surf(X,Y,Z);
    axis equal;axis vis3d;
    shading interp
    light;
    view(58,14)
    axis off
    
   
    