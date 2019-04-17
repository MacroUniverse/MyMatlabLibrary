close all;
lmax = 3;
mat = cell(lmax+1,lmax+1);

% calculate
for l = 0:lmax
    for m = 0:l
        mat{l+1,m+l+1} = yYYy_mat(l,m,2,3,3);
    end
end

% plot
for l = 0:lmax
    for m = 0:l
        i = l+1; j = m+l+1;
        if isempty(mat{i,j}), continue; end
        figure; imagesc(abs(mat{i,j})); axis equal;
        title(['l = ', num2str(l), ', m = ', num2str(m)]);
    end
end
