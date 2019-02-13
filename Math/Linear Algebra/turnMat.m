% generate the 3-by-3 unitary Matrix that turns a vector arount axis 'A' by
% angle 'theta'
% 'A' does not need to be a unit vector

function M = turnMat(A, theta)
C=cos(theta); S=sin(theta);
if S == 0
    M = eye(3); return;
end
A = A/norm(A);
Ax=A(1); Ay=A(2); Az=A(3);
C1=1-C;

M=...  % see PhysWiki
[
C1*Ax*Ax+C      C1*Ax*Ay-Az*S   C1*Ax*Az+Ay*S
C1*Ay*Ax+Az*S  C1*Ay*Ay+C       C1*Ay*Az-Ax*S
C1*Az*Ax-Ay*S   C1*Az*Ay+Ax*S  C1*Az*Az+C 
];
end
