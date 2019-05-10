% diagonalize 2 by 2 matrices
% eigen values only, eig1 < eig2
% supports vector input
function [eig1, eig2] = diag22(a11, a12, a21, a22)
temp1 = a11+a22;
temp2 = sqrt((a11-a22).^2 + 4*a12.*a21);
eig1 = 0.5*(temp1 - temp2);
eig2 = 0.5*(temp1 + temp2);
end
