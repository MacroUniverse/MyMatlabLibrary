% generate a slope grating
close all;
Nx = 800; Ny = 800;
slope = 256/21;
[X,~] = meshgrid(1:Nx, 1:Ny);
I = uint8(mod(round(slope * X), 256));
imshow(I);
imwrite(I, '21.bmp');
