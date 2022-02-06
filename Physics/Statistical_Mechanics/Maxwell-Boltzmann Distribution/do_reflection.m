% 检查所有与墙壁重合的小球， 做镜面反射
function [P, V] = do_reflection(P, V, R, xmax, ymax)
N = size(P, 1);
for i = 1:N
    if P(i,1) < 0 + R || P(i,1) > xmax - R
        V(i,1) = -V(i,1);
    elseif P(i,2) < 0 + R || P(i,2) > ymax - R
        V(i,2) = -V(i,2);
    elseif P(i,3) < 0 + R || P(i,3) > zmax - R
        V(i,3) = -V(i,3);
    end
end
end
