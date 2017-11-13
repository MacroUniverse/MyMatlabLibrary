%反射
%A是法向量. 
%size(v1)=[N,3];
%v1是入射的方向, v2是反射的方向
function v2=reflection(v1,A)
A=vunit(A);
cosine=vunit(v1)*A';
v2=v1-2*sqrt(dot(v1,v1,2)).*cosine*A;
end
