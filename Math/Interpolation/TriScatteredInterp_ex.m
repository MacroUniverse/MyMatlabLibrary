x = rand(1000,1)*4-2;
y = rand(1000,1)*4-2;
z = x.*exp(-x.^2-y.^2);
scatter3(x,y,z,20,'filled');
hold on

F = TriScatteredInterp(x,y,z);
x=linspace(-4,4,100);
y=x;
[x,y]=meshgrid(x,y);
z=F(x,y);
surf(x,y,z)
shading flat
light