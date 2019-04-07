% from 3 contiguous points of a polygon, calculate the 4-th point's
% coordinates
function P = polygon1(P3, N)
N = sym(N);
P = P3(1,:) - P3(2,:) + P3(3,:) + 2*sin((N-4)*sym('pi')/(2*N))*(P3(3,:)-P3(2,:));
P = simplify(P);
end
