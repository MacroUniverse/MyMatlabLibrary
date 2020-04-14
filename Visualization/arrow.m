% plot arrow without distortion by getting current aspect ratio
% will 'hold on' and 'axis manual'
function arrow(x, y, vx, vy, headWidth, color, lineWidth)
hold on; axis manual;
A = norm([vx,vy]);
if ~exist('headWidth', 'var') || isempty(headWidth)
    headWidth = 0.2 * A;
end
if ~exist('color', 'var') || isempty(color)
    color = 'k';
end
if ~exist('lineWidth', 'var') || isempty(lineWidth)
    lineWidth = 1;
end
[x1, y1] = xy2equi(x, y);
[vx1, vy1] = xy2equi(vx, vy);
A1 = norm([vx1, vy1]);
headWidth1 = headWidth / A * A1;
Ptri1 = arrowTri(x1, y1, vx1, vy1, headWidth1);
tri_x1 = Ptri1(:,1); tri_y1 = Ptri1(:,2);
[tri_x2, tri_y2] = equi2xy(tri_x1, tri_y1);
vx = vx * (1-headWidth/A*0.3); vy = vy * (1-headWidth/A*0.3);
% plot line
plot([x, x + vx], [y, y + vy], 'Color', color, 'LineWidth', lineWidth);
hold on;
% plot arrow head (triangle)
fill(tri_x2, tri_y2, 'w', 'FaceColor', color, 'EdgeAlpha', 0);
end

% calculate the arrow triangle
function Ptri = arrowTri(x, y, vx, vy, headWidth)
A = norm([vx,vy]);
u = [vx, vy, 0] / A;
Ptri = [0, -1; 0.5, -1; 0, 0; -0.5, -1; 0, -1]; % triangle
Ptri = Ptri * headWidth;
Ptri = [Ptri, zeros(5, 1)];
Ptri = turn(Ptri, [0, 1, 0], u);
Ptri = Ptri(:, 1:2) + [x + vx, y + vy];
end
