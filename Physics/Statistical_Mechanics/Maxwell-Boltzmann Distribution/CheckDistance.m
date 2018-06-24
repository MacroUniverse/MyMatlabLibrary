%检查划分好的粒子是否跟别的粒子的距离变近
%注意只标记较小序号的粒子

list=false(size(Box)); 

for kk=2:Nz-1
for jj=2:Ny-1
for ii=2:Nx-1
    %所在的3*3*3空间中可能碰到的粒子的序号
    ind=[Box{[ii,ii+1],jj,kk}.....
         Box{ii-1:ii+1,jj,kk}.....
         Box{ii-1:ii+1,jj-1:jj+1,kk+1}];
    %判断距离是否小于临界值
    Nnear=numel(ind);
    for n=1:Nnear-1
    for m=n+1:Nnear
        ind1=min(ind(n),ind(m)); ind2=max(ind(n),ind(m));
        if norm(P(ind1)-P(ind2))<Rcriti
            list{ind1}=[list{ind1} ind2];%只标记较小序号的粒子
        end
    end
    end
end
end
end