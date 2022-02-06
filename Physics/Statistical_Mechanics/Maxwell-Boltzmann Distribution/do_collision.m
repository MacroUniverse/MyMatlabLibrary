% 检查所有会发生碰撞的小球， 并计算碰撞后的速度
% 需要求的坐标 P, 速度 v, 半径 R
function [P, V] = do_collision(P, V, R)
N = size(P,1);
for i = 1:N
    for j = 1:N
        Rij = P(i,:)-P(j,:);
        if norm(Rij) < 2*R
            [V(i,:), V(j,:)] = collision(V(i,:), V(j,:), Rij);
        end
    end
end
end
