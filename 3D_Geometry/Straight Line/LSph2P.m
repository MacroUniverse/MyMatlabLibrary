% intersection between line and sphere
% numel(L)=6, size(P)=[N,3], numel(R)=1
% TODO: 应该支持多条支线而不是多个球
function [P1,P2] = LSph2P(L6, P, R)
L6 = L6(:)';
P0 = L6(1:3); v0 = L6(4:6)/norm(L6(4:6));
P0_P = P0-P;
b = 2*P0_P*v0';
c = dot(P0_P, P0_P, 2) - R^2;
d = b.^2 - 4*c;
if d < 0
    P1 = []; P2 = []; return;
end
d = sqrt(d);
P1 = 0.5*(-b -d).*v0 + P0;
if d == 0
    P2 = []; return;
end
P2 = 0.5*(-b +d).*v0 + P0;
end
