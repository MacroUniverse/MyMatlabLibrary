% field on focal plane of a 2-f system
% E0 is the complex field on the input plane
% E0 must be a square matrix
% L0 is the physical length of the input plane
% gain (optional) is for image display intensity, done by saturating bright pixels

function [E, L] = lensFourier(E0, L0, f, lambda, gain)
% plot object field
[N, temp] = size(E0);
if N ~= temp
    error('E0 must be a square matrix');
end

% Fourier transform
E = ifftshift(fft2(fftshift(E0)));
L = lambda*f*N/L0; % length of the image plane.

% show result image
if nargin <= 4
    gain = 1;
end
figure();
Imagesc(L,L,abs(E).^2, gain);
end

% my version of imagesc
% y axis points up
% gain (optional argument) is done by saturating high intensity
% if gain is not set, 0 = darkest, max(I(:)) = brightest
function Imagesc(Lx, Ly, I, gain)
[Nx,Ny] = size(I);
x = linspace(-0.5*Lx, 0.5*Lx, Nx);
y = linspace(-0.5*Ly, 0.5*Ly, Ny);
if ~isreal(I(:)) || gain == 1
    warning('I must be a real matrix! displaying abs(I)');
    I = abs(I);
end
if nargin > 3
    threashold = max(abs(I(:)))/gain;
    I(abs(I) > threashold) = threashold;
    imagesc(x, y, flipud(I),[0,threashold]); colorbar;
else
    imagesc(x, y, flipud(I),[0,max(I(:))]); colorbar;
end
xlabel('x'); ylabel('y'); 
colormap('gray');
axis image; view([0,-90]);
end