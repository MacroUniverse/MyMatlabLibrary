

x0=input('输入相机坐标x');
y0=input('输入相机坐标y');
z0=input('输入相机坐标z');

cam=setcam(x0,y0,z0,'cart','N97');

I=imread('201314.bmp');
cam(6,1)=size(I,2);
cam(6,2)=size(I,1);
cam(6,3)=input('输入焦距(单位:像素)');

ix=cam(1,1); iy=cam(1,2); iz=cam(1,3);
jx=cam(2,1); jy=cam(2,2); jz=cam(2,3);
kx=cam(3,1);ky=cam(3,2);kz=cam(3,3);
pi=cam(5,1);pj=cam(5,2);pk=cam(5,3);
xi=cam(6,3);

[y, x]=ndgrid(0:cam(6,2)-0.5, 0:cam(6,1)-0.5);
[m,n]=spatial2mn2(x, y,cam);

X=zeros(size(m)); Y=X;
for ii=1:numel(m)
    A=[(xi*ix-m(ii)*kx) (xi*iy-m(ii)*ky);  (xi*jx-n(ii)*kx) (xi*jy-n(ii)*ky)];
    b=[pk*m(ii)-pi*xi;   pk*n(ii)-pj*xi];
    temp=A\b;
    X(ii)=temp(1); Y(ii)=temp(2);
end

h=surf(X,Y,zeros(size(X))); shading flat; axis equal;  view([90 90]);

temp=double(max(max(max(I))));
if numel(size(I))==2
    I=double(repmat(I,[1 1 3]))/temp;
end
set(h,'Cdata',double(I)/temp);
xlabel('x'); ylabel('y');




