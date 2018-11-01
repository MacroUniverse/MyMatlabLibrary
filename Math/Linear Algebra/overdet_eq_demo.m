% solving over-determined linear system

close all;
M = 1000;
N = 100;
x = rand(1, N) + 1i*rand(1, N); x = x';
A = rand(M, N); AH = A';
y = A*x;
y1 = y + 0.5*rand(M, 1) - 0.25;
x1 = A\y1; % solve y1 = A*x1

x2 = (A'*A)\(A'*y1);

diff = max(abs(x1(:)-x2(:)));
