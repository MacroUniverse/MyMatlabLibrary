% surf() in spherical coordinate
% R, Th, Ph are 2D matrices
% 

function h = surfSph(R,Th,Ph,varargin)
if isvector(R) == 1 && isvector(Th) == 1
    [R,Th] = ndgrid(R, Th);
end
if Ph == 1
    Ph = Ph*ones(size(R));
end
[X,Y,Z] = sph2cart(Ph,pi/2-Th,R);
h = surf(X,Y,Z,varargin{:});
shading flat; axis equal;
xlabel x; ylabel y; zlabel z;
set(datacursormode(gcf), 'UpdateFcn', @datatip);
cameratoolbar;
end
