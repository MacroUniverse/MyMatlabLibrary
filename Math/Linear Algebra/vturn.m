% turn 3D points from direction 'A1' to direction 'A2'
% 'A1','A2' do not need to be unit vectors
% 'X', 'Y', 'Z' arrays must have the save number of elements
% if you already have the matrix [X(:)';Y(:)';Z(:)'], just use 'vturnMat()'

function [X1,Y1,Z1] = vturn(X,Y,Z,A1,A2)
M = vturnMat(A1,A2);

XYZ1=M*[X(:)';Y(:)';Z(:)'];

X1(:)=XYZ1(1,:); X1 = reshape(X1,size(X));
Y1(:)=XYZ1(2,:); Y1 = reshape(Y1,size(Y));
Z1(:)=XYZ1(3,:); Z1 = reshape(Z1,size(Z));
end
