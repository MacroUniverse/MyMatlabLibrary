% return the maximum element in a matrix and the subscript

function [Max,row,col] = MaxSub(Mat)
[Max,ind] = max(Mat(:));
[row,col] = ind2sub(size(Mat),ind);
end