function V=normalize(V)
for ii=1:size(V,2)
    V(:,ii)=V(:,ii)/norm(V(:,ii));
end
end