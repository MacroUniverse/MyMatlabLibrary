[x,y,z]=meshgrid(-2:0.2:2, -2:0.25:2, -2:0.16:2);
v=x.*exp(-x.^2-y.^2-z.^2);
xs=-0.7:0.2:0.7; ys=[]; zs=[];
slice(x,y,z,v,xs,ys,zs)
colorbar
shading interp
colormap hsv
xlabel('x'), ylabel('y'), zlabel('z')
title('The colo-to-v(x,y,z) mapping')
view([-22, 39])
alpha(1)