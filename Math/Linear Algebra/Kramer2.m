% Using Kramer's rule to solve 2*2 linear system;
% No singularity checking

function V = Kramer2(Mat,b)
InvDet = 1/det(Mat);
V = [0;0];
V(1) = (b(1)*Mat(2,2)-b(2)*Mat(1,2))*InvDet;
V(2) = (Mat(1,1)*b(2)-Mat(2,1)*b(1))*InvDet;
end