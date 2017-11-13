% mixed second partial derivative for f(x,y)

% f is a funcion handle
% size(DxDy) = size(x0) = size(y0)

function DxDy = D2mix(f,x0,y0)
h = 5e-5; % 5e-5; % optimized for exp(x^2+y^2) at (1,1).
DxDy = (f(x0-h,y0-h) + f(x0+h,y0+h) - f(x0-h,y0+h) - f(x0+h,y0-h))/(4*h*h);
end