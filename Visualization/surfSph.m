% surf() in spherical coordinate
% usage 1. R,Th,Ph,Val are 2D matrices in same shape
% usage 2. R,Th,Ph are vector,vector,scalar
% usage 3. R,Th,Ph are vector,scalar,vector
% surf() in spherical coordinate
% usage 1. R,Th,Ph,Val are 2D matrices in same shape
% usage 2. R,Th,Ph are vector,vector,scalar
% usage 3. R,Th,Ph are vector,scalar,vector
function h = surfSph(R,Th,Ph,Val,varargin)
% resize
if isvector(R) && isvector(Th)
    [R,Th] = ndgrid(R, Th);
end
if isvector(R) && isvector(Ph)
    [R,Ph] = ndgrid(R,Ph);
end
if isscalar(Th)
    Th = Th*ones(size(R));
end
if isscalar(Ph)
    Ph = Ph*ones(size(R));
end
if ~isequal(size(R),size(Th)) || ...
    ~isequal(size(Th),size(Ph)) || ...
    ~isequal(size(Ph),size(Val))
    error('wrong shape for Th, Ph, Val');
end
% plot
[X,Y,Z] = Sph2Cart(R, Th, Ph);
h = surf(X,Y,Z,Val,varargin{:});
view(0,0);
shading flat; axis equal;
xlabel x; ylabel y; zlabel z;
set(datacursormode(gcf), 'UpdateFcn', @datatip);
cameratoolbar;
end
