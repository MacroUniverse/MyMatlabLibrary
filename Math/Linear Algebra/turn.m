% turn 3D points around axis 'A' by angle 'theta'
% 'A' does not need to be unit vector
% 'X', 'Y', 'Z' arrays must have the save number of elements
% if you already have the matrix [X(:)';Y(:)';Z(:)'], just use 'turnMat()'

function [X1,Y1,Z1]=turn(X,Y,Z,A,theta)
M = turnMat(A,theta);

XYZ1=M*[X(:)';Y(:)';Z(:)'];

X1(:)=XYZ1(1,:); X1 = reshape(X1,size(X));
Y1(:)=XYZ1(2,:); Y1 = reshape(Y1,size(Y));
Z1(:)=XYZ1(3,:); Z1 = reshape(Z1,size(Z));
end
