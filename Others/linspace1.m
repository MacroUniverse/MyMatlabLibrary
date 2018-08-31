% another version of linspace
% x = linspace(x1, x2, N+1); x = x(1:end-1);
function x = linspace1(x1, x2, N)
x = linspace(x1, x2 - (x2-x1)/N, N);
end
