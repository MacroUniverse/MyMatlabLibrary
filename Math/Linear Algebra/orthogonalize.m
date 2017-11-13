% orthogonalize vector V given orthogonal vectors basis V1
function V=orthogonalize(V,V1)
for ii=1:size(V1,2)
    V1=normalize(V1);
    V=V-V'*V1(:,ii)*V1(:,ii);
end
end