% plot arrow
% assuming 'axis equal' is used
function arrow0(x, y, vx, vy, headWidth, color)
A = norm([vx,vy]);
if ~exist('headWidth', 'var') || isempty(headWidth)
    headWidth = 0.2;
end
if ~exist('color', 'var') || isempty(color)
    color = 'k';
end
plot([x, x + vx], [y, y + vy], 'Color', color); hold on;

u = [vx, vy, 0] / A;
Ptri = [0, -1; 0.5, -1; 0, 0; -0.5, -1; 0, -1]; % triangle
Ptri = Ptri * headWidth;
Ptri = [Ptri, zeros(5, 1)];
Ptri = turn(Ptri, [0, 1, 0], u);
Ptri = Ptri(:, 1:2) + [x + vx, y + vy];
Fill(Ptri, 'w', 'FaceColor', color, 'EdgeAlpha', 0);
end
