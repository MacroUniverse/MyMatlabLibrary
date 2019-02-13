% generate the 3-by-3 unitary Matrix that turns a vector from direction 'A1' to direction 'A2'
% 'A1','A2' does not have to be unit vectors

function M = vturnMat(A1, A2)
A1 = A1/norm(A1); A2 = A2/norm(A2);
C=dot(A1,A2); % cos(theta)
A = cross(A1,A2);
S = norm(A); % sin(theta)
if S == 0
    M = eye(3); return;
end
A = A/S;
Ax = A(1); Ay = A(2); Az = A(3);
C1=1-C;

M=...  % see PhysWiki
[
C1*Ax*Ax+C      C1*Ax*Ay-Az*S   C1*Ax*Az+Ay*S
C1*Ay*Ax+Az*S  C1*Ay*Ay+C       C1*Ay*Az-Ax*S
C1*Az*Ax-Ay*S   C1*Az*Ay+Ax*S  C1*Az*Az+C 
];
end
