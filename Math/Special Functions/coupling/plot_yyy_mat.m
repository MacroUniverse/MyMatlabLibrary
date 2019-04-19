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

mat = cell(lmax+1,lmax+1);
Mat = cell(lmax+1,0);
Mat_9j = cell(lmax+1,0);

for l = 0:lmax
    m = 0;
    mat{l+1,m+l+1} = yYYy_mat(l,m,L,M,l1,l2);
    Mat{l+1} = mat{l+1,m+l+1};
    for m = 1:l
        mat{l+1,m+l+1} = yYYy_mat(l,m,L,M,l1,l2);
        Mat{l+1} = Mat{l+1} + mat{l+1,m+l+1} + mat{l+1,m+l+1}';
    end
    Mat{l+1} = Mat{l+1} * (-1)^l/sqrt(2*l+1);
    Mat_9j{l+1} = yyy_mat_9j(l,L,M,l1,l2);
end

% plot Mat
x = 1:size(Mat{1},1); y = x;
[X,Y] = ndgrid(x,y);
for l = 0:lmax
    figure;
    %squares(x,y,abs(Mat{l+1}));
    surfCart(X,Y,abs(Mat{l+1})); shading faceted;
    axis equal; title(['l = ', num2str(l),...
        '  err =', num2str(max(max(abs(Mat{l+1} - Mat_9j{l+1}))))]);
    colorbar; hold on;
    
    % plot dividers for L
    plot3([5,5],[1,Ndim],[0.1,0.1],'w');
    plot3([1,Ndim],[5,5],[0.1,0.1],'w');
    
    plot3([32,32],[1,Ndim],[0.1,0.1],'w');
    plot3([1,Ndim],[32,32],[0.1,0.1],'w');
    
    % plot dividers for M
    plot3([14,14],[1,Ndim],[0.1,0.1],'r');
    plot3([1,Ndim],[14,14],[0.1,0.1],'r');
    
    plot3([23,23],[1,Ndim],[0.1,0.1],'r');
    plot3([1,Ndim],[23,23],[0.1,0.1],'r');
    
    plot3([43,43],[1,Ndim],[0.1,0.1],'r');
    plot3([1,Ndim],[43,43],[0.1,0.1],'r');
    
    plot3([54,54],[1,Ndim],[0.1,0.1],'r');
    plot3([1,Ndim],[54,54],[0.1,0.1],'r');
    
    plot3([65,65],[1,Ndim],[0.1,0.1],'r');
    plot3([1,Ndim],[65,65],[0.1,0.1],'r');
    
    plot3([76,76],[1,Ndim],[0.1,0.1],'r');
    plot3([1,Ndim],[76,76],[0.1,0.1],'r');
end
