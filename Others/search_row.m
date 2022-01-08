% search a row of a 2D matrix
function ind = search_row(row, mat)
N = size(mat,1);
for i = 1:N
    if isequal(row, mat(i,:))
        ind = i; return;
    end
end
ind = -1;
end
