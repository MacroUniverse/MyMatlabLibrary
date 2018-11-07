% my version of surf()
% X, Y, Z are 2D matrices

function h = surfCart(X,Y,Z,varargin)
h = surf(X,Y,Z,varargin{:});
shading interp; axis equal;
xlabel x; ylabel y; zlabel z;
set(datacursormode(gcf), 'UpdateFcn', @datatip);
end
