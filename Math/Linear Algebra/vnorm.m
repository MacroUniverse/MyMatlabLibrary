function norm=vnorm(V)
Nv=size(V,2);
norm=zeros(1,Nv);
for ii=1:size(V,2)
    norm(ii)=sqrt(sum(V(:,ii).^2));
end
end