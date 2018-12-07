% scatter color squares to show the value of matrix elements
% this is the closest thing to surf()/imagesc() with exact face
                   % position/color control and precise datatip
% x, y are ascending vectors, C is Nx-by-Ny matrix
% size is optional
function squares(x, y, C, size)
Nx = numel(x); Ny = numel(y);
if ~exist('size','var')
    axis square;
    h = gca;
    h.Units = 'pixels';
    size = 0.95*min(h.Position(3)/(Nx+1), h.Position(4)/(Ny+1));
end
[X,Y] = ndgrid(x,y);
% the size here is actually the area in pixels
scatter(X(:),Y(:),size*size,C(:),...
    'Marker','square','MarkerFaceColor','flat',...
    'MarkerEdgeColor','none');
h.Units = 'normalized';
Dx = (x(end)-x(1))/(Nx-1);
Dy = (y(end)-y(1))/(Ny-1);
axis([x(1)-Dx, x(end)+Dx, y(1)-Dy, y(end)+Dy]);
view(90,90);
colorbar;
set(datacursormode(gcf), 'UpdateFcn', @datatip);
xlabel x; ylabel y;
end
