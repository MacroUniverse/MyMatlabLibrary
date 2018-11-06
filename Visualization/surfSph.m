% surf() in spherical coordinate
% R, Th, Ph are 2D matrices

function h = surfSph(R,Th,Ph,varargin)
[X,Y,Z] = sph2cart(Ph,pi/2-Th,R);
h = surf(X,Y,Z,varargin{:});
shading interp; axis equal;
xlabel x; ylabel y; zlabel z;
set(datacursormode(gcf), 'UpdateFcn', @datatip);
end
