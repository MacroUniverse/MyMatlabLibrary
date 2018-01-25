% my version of imagesc
% y axis points up
% gain (optional argument) is done by saturating high intensity
% if gain is not set, 0 = darkest, max(I(:)) = brightest

function Imagesc(Lx, Ly, I, gain)
[Nx,Ny] = size(I);
x = linspace(-0.5*Lx, 0.5*Lx, Nx);
y = linspace(-0.5*Ly, 0.5*Ly, Ny);
if ~isreal(I(:))
    warning('I must be a real matrix! displaying abs(I)');
    I = abs(I);
end
if nargin > 3
    threashold = max(abs(I(:)))/gain;
    I(abs(I) > threashold) = threashold;
    imagesc(x, y, flipud(I),[min(I(:)),threashold]); colorbar;
else
    imagesc(x, y, flipud(I),[min(I(:)),max(I(:))]); colorbar;
end
xlabel('x'); ylabel('y'); 
colormap('gray');
axis image; view([0,-90]);
end