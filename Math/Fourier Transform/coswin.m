% cos window on both end of a vector
% fade N*dx on both side of [-L/2, L/2]
function f1 = coswin(f, N)
    f1 = f;
    win = (-cos(linspace1(0, pi, N)) + 1)/2;
    f1(1:N) = f1(1:N).*win;
    f1(end-N+1:end) = f1(end-N+1:end).*fliplr(win);
end

% another version of linspace
% x = linspace(x1, x2, N+1); x = x(1:end-1);
function x = linspace1(x1, x2, N)
x = linspace(x1, x2 - (x2-x1)/N, N);
end
