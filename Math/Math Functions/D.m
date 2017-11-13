% take first derivative of a function handle
function out = D(f,x)
h = 1e-9;
invh = 1/h;
inv2h = 0.5*invh;
N = numel(x);
out = (f(x+h)-f(x-h))*inv2h;
end