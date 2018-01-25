% embed a small image Nx0*Ny0 into the middle of a larger white image Nx*Ny
% it doesn't matter if I0 is double or uint8 or uint16 etc.
% it doesn't matter if I0 is 2d or 3d (rgb) matrix.
function I = imembed(I0, Nx, Ny)
Ny0 = size(I0, 1);
Nx0 = size(I0, 2);
Nz0 = size(I0, 3);
if mod(Nx - Nx0, 2) == 0
    dx = (Nx - Nx0)*0.5;
    Ileft = zeros(Ny0, dx, Nz0);
    Iright = Ileft;
else
    dx = (Nx - Nx0 - 1)*0.5;
    Ileft = zeros(Ny0, dx, Nz0);
    Iright = zeros(Ny0, dx + 1, Nz0);
end
if mod(Ny - Ny0, 2) == 0
    dy = (Ny - Ny0)*0.5;
    Iup = zeros(dy, Nx, Nz0);
    Idown = Iup;
else
    dy = (Ny - Ny0 - 1)*0.5;
    Iup = zeros(dy, Nx, Nz0);
    Idown = zeros(dy+1, Nx, Nz0);
end
I = [Iup; Ileft, I0, Iright; Idown];
end
