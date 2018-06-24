%生成一个圆环管道
    clear
    clc
    th=((-200:200)/401*2*pi*6)';
    x=exp(th/(2*pi)).*cos(th);
    y=exp(th/(2*pi)).*sin(th);
    z=zeros(size(th));
    M=[x,y,z];
    [Ax,Ay,Az]=TangentLine(x,y,z);
    
    A=[Ax,Ay,Az];
    th=[th,th,th];
    A=A.*exp(th/(2*pi))*0.46;
    
    [X,Y,Z]=ring3D(M,A,40);
    [X,Y,Z]=turnA(X,Y,Z,[1 1 1]);
    surf(X,Y,Z);
    axis equal;axis vis3d;
    shading interp
    light;
    view(58,14)
    axis off
    
   
    