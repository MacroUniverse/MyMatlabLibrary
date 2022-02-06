% 反射
% A 是法向量. 
% size(v1) = [N,3];
% v1 是入射的方向, v2 是反射的方向
function v2 = reflection(v1,A)
vnorm = sqrt(v1' * v1);
v1unit = v1 / vnorm;
cosine = v1unit' * A;
v2 = v1 - (2*vnorm*cosine)*A;
end
