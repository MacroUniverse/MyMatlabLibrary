% calculate <y|y_{ll}^{00}|y'>
close all;

% === params ===
L_max = 2; M_max = 2;
l1_max = 3; l2_max = 3;
lmax = 6;
% ==============

[L, M, l1, l2, parity, exclude] = AngBasis(L_max, M_max, l1_max, l2_max);
Ndim = numel(L);
disp([(1:Ndim)',L, M, l1, l2, parity, exclude]);

Mat = cell(lmax+1,0);
Mat_9j = cell(lmax+1,0);

for l = 0:lmax
    % Mat{l+1} = simplify(yyy_mat(sym(l),sym(L),sym(M),sym(l1),sym(l2)));
    Mat{l+1} = yyy_mat(l,L,M,l1,l2);
    Mat_9j{l+1} = yyy_mat_9j(l,L,M,l1,l2);
end

% plot Mat
x = 1:size(Mat{1},1); y = x;
for l = 0:lmax
    figure;
    squares(x,y,(Mat{l+1}));
    surfCart(x,y,(Mat_9j{l+1})); shading faceted;
    axis equal; title(['|<y|y|y>|, l = ', num2str(l),...
        '  err =', num2str(max(abs(double(Mat{l+1}(:)) - Mat_9j{l+1}(:))))]);
    colorbar; hold on;
    
    % plot dividers for L
    plot3([5,5],[1,Ndim+1],[0.1,0.1],'w');
    plot3([1,Ndim+1],[5,5],[0.1,0.1],'w');
    
    plot3([32,32],[1,Ndim+1],[0.1,0.1],'w');
    plot3([1,Ndim+1],[32,32],[0.1,0.1],'w');
    
    % plot dividers for M
    plot3([14,14],[1,Ndim+1],[0.1,0.1],'r');
    plot3([1,Ndim+1],[14,14],[0.1,0.1],'r');
    
    plot3([23,23],[1,Ndim+1],[0.1,0.1],'r');
    plot3([1,Ndim+1],[23,23],[0.1,0.1],'r');
    
    plot3([43,43],[1,Ndim+1],[0.1,0.1],'r');
    plot3([1,Ndim+1],[43,43],[0.1,0.1],'r');
    
    plot3([54,54],[1,Ndim+1],[0.1,0.1],'r');
    plot3([1,Ndim+1],[54,54],[0.1,0.1],'r');
    
    plot3([65,65],[1,Ndim+1],[0.1,0.1],'r');
    plot3([1,Ndim+1],[65,65],[0.1,0.1],'r');
    
    plot3([76,76],[1,Ndim+1],[0.1,0.1],'r');
    plot3([1,Ndim+1],[76,76],[0.1,0.1],'r');
end
