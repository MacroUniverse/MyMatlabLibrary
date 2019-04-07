% second derivative matrix for mono-spaced grid
% (grid points does not include the boundaries)
% D2(i,i-1:i+1) = [1, -2, 1]/dx^2

function D2 = D2mat(N, dx)
D2 = zeros(N, N);
D2(1,1:2) = [-2, 1];
for i = 2:N-1
    D2(i,i-1:i+1) = [1, -2, 1];
end
D2(end,end-1:end) = [1, -2];
D2 = D2 / (dx*dx);
end
