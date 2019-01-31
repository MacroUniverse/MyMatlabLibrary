N = 40;
A = zeros(N, N);
for i = 1:N
    A(i, i) = 1;
end
for i = 1:N-1
    A(i, i+1) = 0.6;
    A(i+1, i) = 0.6;
end
for i = 1:N-5
    A(i, i+5) = 0.4;
    A(i+5, i) = 0.4;
end

f = expA(A);
v = linspace(1, N, N)';
t = 1;

disp(f(t)*v)
