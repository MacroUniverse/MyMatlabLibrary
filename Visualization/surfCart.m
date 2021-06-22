% my version of surf()
% X, Y, Z are 2D matrices
% the color of each facet is determined by the value of the upper-left grid point
% there will be 1 facet for each element of Z, and one more grid-point at
% the end of each dimension

function h = surfCart(x,y,Z,varargin)
[X,Y] = ndgrid([x,2*x(end)-x(end-1)],[y,2*y(end)-y(end-1)]);
Z = [Z, Z(:,end); Z(end,:), Z(end,end)];
h = surf(X,Y,Z,varargin{:});
shading flat;
view(90,90);
axis([min(X(:)), max(X(:)), min(Y(:)), max(Y(:)), [-1, 1]*max(1, max(abs(Z(:))))]);
xlabel x; ylabel y; zlabel z;
colorbar;
set(datacursormode(gcf), 'UpdateFcn', @datatip);
cameratoolbar;
end
