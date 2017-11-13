%相片的立体显示
%若输入的是相片数组, 则直接显示
%若输入的是相片名, 则读取后显示

function imshow3(I)

load Calib_Results cc%相机中心

if ischar(I)
    I=imread(I);
end

s=size(I);
setfigure H50;  
X=[-s(2) s(2); -s(2) s(2)]/2   -(cc(1)-s(2)/2);
Y=[-s(1) -s(1); s(1) s(1)]/2   -(cc(2)-s(1)/2);
Z=[0 0; 0 0];

h=surf(X,Y,Z);
colormap gray;
set(h,'CData',I,'FaceColor','texturemap');
%camproj perspective;
xlabel x; ylabel y;
end