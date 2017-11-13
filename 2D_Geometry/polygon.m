% Draw Equilateral Polygon

N = 6; % side number
a = 2.7; % side length
r = a/(2*sin(pi/N)); % corner radius

th = linspace(0,2*pi,N+1);
x = r*sin(th); y = r*cos(th);
figure; plot(x,y); axis equal