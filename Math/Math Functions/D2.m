% second derivative
% f is function handle, x is row vector
% (f(x+h)+f(x-h)-2*f(x))/h^2
% y''(1)=y''(2)  y''(end)=y''(end-1)

function out = D2(f,x)
h = 2.3e-4; % best value for sin
invh2 = 1/(h*h);
N = numel(x);
out = (f(x+h)+f(x-h)-2*f(x))*invh2;
end